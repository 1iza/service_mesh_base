#!/bin/bash

#---------------#
# 获取环境变量  #
#---------------#
source $INSTALL_PATH/tools/GetEnvVar.sh

#---------------#
# 进程数量检查  #
#---------------#

pid=$(pidof $CHECK_AGENT_NAME)

if [ -z "$pid" ] ; then
    echo "no running $CHECK_AGENT_NAME found , already stopped"
fi



#---------------#
# 停止进程      #
#---------------#

for i in $pid ; do
     echo "kill $CHECK_AGENT_NAME pid=$i [$(ps --no-headers -lf $i)]"
     kill $i
     [ $? -eq 0 ] && ( bash /data/pkg/public-scripts/func/common-cleanup.sh $i ) &
     sleep 3
done

#---------------#
# 二次确认       #
#---------------#

if [ -z "$(pidof $CHECK_AGENT_NAME)" ] ; then
     echo "stop $CHECK_AGENT_NAME ok, all $CHECK_AGENT_NAME got killed"
     echo "output last 20 lines of $log"
     tail -n 20 $log

else
     echo "stop $CHECK_AGENT_NAME failed, found $CHECK_AGENT_NAME still running . see following"
     pidof $CHECK_AGENT_NAME | xargs -r ps -lf
     echo "output last 20 lines of $log"
     tail -n 20 $log
fi

#---------------#
# 进程数量检查  #
#---------------#

pid=$(pidof $APP_NAME)

if [ -z "$pid" ] ; then
    echo "no running $APP_NAME found , already stopped"
    exit 0
fi

#---------------#
# 停止进程      #
#---------------#

for i in $pid ; do
     echo "kill $APP_NAME pid=$i [$(ps --no-headers -lf $i)]"
     kill $i
     [ $? -eq 0 ] && ( bash /data/pkg/public-scripts/func/common-cleanup.sh $i ) &
     sleep 3
done

#---------------#
# 二次确认       #
#---------------#

if [ -z "$(pidof $APP_NAME)" ] ; then
     echo "stop $APP_NAME ok, all $APP_NAME got killed"
     echo "output last 20 lines of $log"
     tail -n 20 $log

else 
     echo "stop $APP_NAME failed, found $APP_NAME still running . see following"
     pidof $APP_NAME | xargs -r ps -lf
     echo "output last 20 lines of $log"
     tail -n 20 $log
fi

#---------------#
# 进程数量检查  #
#---------------#


pid=$(pidof $ENVOY_NAME)

if [ -z "$pid" ] ; then
    echo "no running $ENVOY_NAME found , already stopped"
fi



#---------------#
# 停止进程      #
#---------------#

for i in $pid ; do
     echo "kill $ENVOY_NAME pid=$i [$(ps --no-headers -lf $i)]"
     kill $i
     [ $? -eq 0 ] && ( bash /data/pkg/public-scripts/func/common-cleanup.sh $i ) &
     sleep 3
done

#---------------#
# 二次确认       #
#---------------#

if [ -z "$(pidof $ENVOY_NAME)" ] ; then
     echo "stop $ENVOY_NAME ok, all $ENVOY_NAME got killed"
     echo "output last 20 lines of $log"
     tail -n 20 $log
     rm -rf /dev/shm/envoy_shared_memory_${serviceport}*
     exit 0

else
     echo "stop $ENVOY_NAME failed, found $ENVOY_NAME still running . see following"
     pidof $ENVOY_NAME | xargs -r ps -lf
     echo "output last 20 lines of $log"
     tail -n 20 $log
     exit 1
fi



