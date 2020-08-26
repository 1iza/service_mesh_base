#!/bin/bash

#---------------#
# 配置参数      #
#---------------#

export timeinterval=2             #agent健康检查间隔，默认2秒
export appversion="v2.0"          #版本号，用户区分环境，带测试前缀的为测试版本，例如 test-v1.0
export testversion=false          #是否测试版本
export GOTRACEBACK=crash         #go 生成core 文件选项

#---------------#
#  端口初始值   #
#---------------#

export ingressport=16000      #envoy服务需要发送请求使用的端口, 这是初始值，默认不需要改，如果被占用会递增生成新的端口
export serviceport=17000      #服务需要监听的端口，这是初始值，如果被占用会递增生成新的端口
export egressport=18000       #服务需要发送请求使用的端口,  这是初始值，默认不需要改，如果被占用会递增生成新的端口
export adminport=9901       #admin使用的端口,  这是初始值，默认不需要改，如果被占用会递增生成新的端口


#---------------#
#端口占用检查   #
#---------------#

export serviceport=`python3 $INSTALL_PATH/tools/CheckPort.py ${serviceport} 1`    #如果被占用会递增生成新的端口
export ingressport=`python3 $INSTALL_PATH/tools/CheckPort.py ${ingressport} 1`    #如果被占用会递增生成新的端口
export egressport=`python3 $INSTALL_PATH/tools/CheckPort.py ${egressport} 1`      #如果被占用会递增生成新的端口
export adminport=`python3 $INSTALL_PATH/tools/CheckPort.py ${adminport} 1`      #如果被占用会递增生成新的端口

#----------------#
#更新配置文件端口#
#----------------#

if [ ! $servicename ]; then
  echo "servicename IS NULL， quit"
  exit 1
fi 

if [ ! $prefix ]; then
  echo "prefix is setted /edu_sp/grpc_app/"
  prefix="/edu_sp/grpc_app/"  #服务前缀,默认/edu_sp/grpc_app/,不需要修改
fi 


python3 $INSTALL_PATH/tools/UpdatePortinConf.py $INSTALL_PATH/tools/envoy_app.yaml  ${ingressport} ${egressport} ${serviceport} ${adminport}
python3 $INSTALL_PATH/tools/SaveSrvname.py $INSTALL_PATH/tools/srvconfig.json ${servicename}
#测试版本需要修改egress fliter
if [ "$testversion" = true ] ; then
    python3 $INSTALL_PATH/tools/UpdateEgressFliter.py $INSTALL_PATH/tools/envoy_app.yaml ${appversion}
fi
