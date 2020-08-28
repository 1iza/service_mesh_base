#!/bin/bash


#----------------#
#更新配置文件端口#
#----------------#

if [ ! $servicename ]; then
  echo "servicename IS NULL， quit"
  exit 1
fi 

python3 $INSTALL_PATH/tools/UpdatePortinConf.py $INSTALL_PATH/tools/envoy_app.yaml  ${ingressport} ${egressport} ${serviceport} ${adminport}
python3 $INSTALL_PATH/tools/SaveSrvname.py $INSTALL_PATH/tools/srvconfig.json ${servicename}
#测试版本需要修改egress fliter
if [ "$testversion" = true ] ; then
    python3 $INSTALL_PATH/tools/UpdateEgressFliter.py $INSTALL_PATH/tools/envoy_app.yaml ${appversion}
fi
