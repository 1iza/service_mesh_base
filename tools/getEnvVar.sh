#!/bin/bash

#获取参数
export ingressport=$(python3 $INSTALL_PATH/tools/GetPortfromConf.py $INSTALL_PATH/tools/envoy_app.yaml listeners ingress_listener)
export egressport=$(python3 $INSTALL_PATH/tools/GetPortfromConf.py $INSTALL_PATH/tools/envoy_app.yaml listeners egress_listener)
export adminport=$(python3 $INSTALL_PATH/tools/GetPortfromConf.py $INSTALL_PATH/tools/envoy_app.yaml admin)
export serviceport=$(python3 $INSTALL_PATH/tools/GetPortfromConf.py $INSTALL_PATH/tools/envoy_app.yaml clusters local_app)
export servicename=$(python3 $INSTALL_PATH/tools/GetSrvname.py $INSTALL_PATH/tools/srvconfig.json)

export ENVOY_NAME=envoy_${servicename}
export CHECK_AGENT_NAME=checkAgent_${servicename}_d


#启动参数
export envoy_cmd=`echo "exec -a ${ENVOY_NAME}  ./envoy -c $INSTALL_PATH/tools/envoy_app.yaml --disable-hot-restart --base-id ${serviceport}  >> $log 2>&1 & "`
export check_agent_cmd=`echo "exec -a ${CHECK_AGENT_NAME} ./checkAgent -appname ${prefix}${servicename} -mode 1 -filewatcher 2 -appport ${serviceport} -interval ${timeinterval} -config $INSTALL_PATH/tools/checkconfig.json -envoyport ${ingressport} -appVersion ${appversion} -testVersion=${testversion} -envoyAdminPort ${adminport}  >> $log 2>&1 & "`



echo "*** check_agent_name:${CHECK_AGENT_NAME} ***"  >> $log
echo "*** envoy_name:${ENVOY_NAME} ***"  >> $log
echo "*** servicename:${servicename} ***"  >> $log
echo "*** servicename:${servicename} ***"  >> $log
echo "*** ingressport:${ingressport} ***"  >> $log
echo "*** egressport:${egressport} ***"  >> $log
echo "*** adminport:${adminport} ***"  >> $log
echo "*** serviceport:${serviceport} ***"  >> $log
echo "*** appversion:${appversion} ***"  >> $log
echo "*** envoy_cmd:${envoy_cmd} ***"  >> $log
echo "*** check_agent_cmd:${check_agent_cmd} ***"  >> $log