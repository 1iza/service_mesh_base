#!/bin/bash

LD_LIBRARY_PATH=$INSTALL_PATH/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
ldconfig

#---------------#
# 保存端口到配置#
#---------------#

bash $INSTALL_PATH/tools/SaveMeshConf.sh
#---------------#
# 获取环境变量  #
#---------------#
source $INSTALL_PATH/tools/GetEnvVar.sh


#---------------#
# 进程数量设置  #
#---------------#

count=1

#-------------#
# 进程数检查  #
#-------------#

x=$(pidof $ENVOY_NAME |wc -w)
y=$((count-x))
echo "delta=$y"
#--------------------------#
# 进程数大于 $count 就退出 #
#--------------------------#

if [ $y -le 0 ] ; then
   pidof ${ENVOY_NAME} | xargs -r ps -lf
   echo "${ENVOY_NAME} num ($x) >= $count , no need to start , quit"
else
   #---------------#
   # 启动进程      #
   #---------------#

   cd $INSTALL_PATH/tools || exit 1

   for ((i=1;i<=$y;i++)); do
        echo "start ${envoy_cmd}"
        bash -c "${envoy_cmd}"
        sleep 2
   done

   #---------------#
   # 二次确认      #
   #---------------#

   if [ $(pidof $ENVOY_NAME |wc -w) -eq $count ] ; then
        echo "start $ENVOY_NAME ok"  
        echo "output last 20 lines of $log"
        tail -n 20 $log
        pidof $ENVOY_NAME |xargs -r ps -lf
   else
        echo "start $ENVOY_NAME failed"
        tail -n 20 $log
        pidof $ENVOY_NAME |xargs -r ps -lf
        exit 1
   fi
fi


#---------------#
# 进程数量设置  #
#---------------#

count=1  #目前只支持启动一个

#-------------#
# 进程数检查  #
#-------------#


x=$(pidof $APP_NAME |wc -w)
y=$((count-x))
echo "delta=$y"

#--------------------------#
# 进程数大于 $count 就退出 #
#--------------------------#

if [ $y -le 0 ] ; then
   pidof $APP_NAME | xargs -r ps -lf
   echo "$APP_NAME num ($x) >= $count , no need to start , quit"

else

   #---------------#
   # 启动进程      #
   #---------------#

   cd $INSTALL_PATH/bin || exit 1

   for ((i=1;i<=$y;i++)); do
        echo "start #$i"
        nohup ${APP_CMD} &
        sleep 2
   done

   #---------------#
   # 二次确认      #
   #---------------#

   if [ $(pidof $APP_NAME |wc -w) -eq $count ] ; then
        echo "start $APP_NAME ok"
        echo "output last 20 lines of $log"
        tail -n 20 $log
        echo "output last 20 lines of /data/yy/log/$APP_NAME/${APP_NAME}.log"
        tail -n 20 /data/yy/log/$APP_NAME/${APP_NAME}.log
        pidof $APP_NAME |xargs -r ps -lf
   else
        echo "start $APP_NAME failed"
        echo "output last 20 lines of $log"
        tail -n 20 $log
        echo "output last 20 lines of /data/yy/log/$APP_NAME/${APP_NAME}.log"
        tail -n 20 /data/yy/log/$APP_NAME/${APP_NAME}.log
        pidof $APP_NAME |xargs -r ps -lf
        
        bash $INSTALL_PATH/admin/stop.sh 
        exit 1
   fi

fi



#---------------#
# 进程数量设置  #
#---------------#

count=1

#-------------#
# 进程数检查  #
#-------------#


x=$(pidof $CHECK_AGENT_NAME |wc -w)
y=$((count-x))
echo "delta=$y"

#--------------------------#
# 进程数大于 $count 就退出 #
#--------------------------#

if [ $y -le 0 ] ; then
   pidof ${CHECK_AGENT_NAME} | xargs -r ps -lf
   echo "${CHECK_AGENT_NAME} num ($x) >= $count , no need to start , quit"
   exit 0
fi

#---------------#
# 启动进程      #
#---------------#

cd $INSTALL_PATH/tools || exit 1

for ((i=1;i<=$y;i++)); do
     echo "start ${check_agent_cmd}"
     bash -c "${check_agent_cmd}"
     sleep 2
done

exit $?
