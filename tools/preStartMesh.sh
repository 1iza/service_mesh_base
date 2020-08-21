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


