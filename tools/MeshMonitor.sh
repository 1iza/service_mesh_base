#!/bin/bash

#---------------#
# 获取环境变量  #
#---------------#
source $INSTALL_PATH/tools/GetEnvVar.sh


#---------------#
# 进程数量设置   #
#---------------#

count=1

#---------------#
# 进程数量判断  #
#---------------#

pids=$(pidof $CHECK_AGENT_NAME)

num=$(echo $pids |wc -w)

if [ $num -lt $count ] ; then

      # 进程数量异常，执行异常处理

      echo "$(date +'%F %T')| $CHECK_AGENT_NAME num = $num [< $count] , pid=[$pids]" >> $log

      ps -lf $pids

      bash $INSTALL_PATH/admin/resolve.sh

      exit $?
else

      # 进程数量正常

      echo "current num of $CHECK_AGENT_NAME = $num , pid=[$pids]"

      ps -lf $pids

fi

#---------------#
# 进程数量判断  #
#---------------#


pids=$(pidof $ENVOY_NAME)

num=$(echo $pids |wc -w)

if [ $num -lt $count ] ; then

      # 进程数量异常，执行异常处理

      echo "$(date +'%F %T')| $ENVOY_NAME num = $num [< $count] , pid=[$pids]" >> $log

      ps -lf $pids

      bash $INSTALL_PATH/admin/resolve.sh

      exit $?
else

      # 进程数量正常

      echo "current num of $ENVOY_NAME = $num , pid=[$pids]"

      ps -lf $pids

fi



#---------------#
# 进程数量判断  #
#---------------#

pids=$(pidof $APP_NAME)

num=$(echo $pids |wc -w)

if [ $num -lt $count ] ; then

      # 进程数量异常，执行异常处理

      echo "$(date +'%F %T')| $APP_NAME num = $num [< $count] , pid=[$pids]" >> $log

      ps -lf $pids

      bash $INSTALL_PATH/admin/resolve.sh

      exit $?
else

      # 进程数量正常

      echo "current num of $APP_NAME = $num , pid=[$pids]"

      ps -lf $pids

      exit 0
fi