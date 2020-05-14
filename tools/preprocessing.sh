python3 $INSTALL_PATH/tools/UpdatePortinConf.py $INSTALL_PATH/tools/envoy_app.yaml  ${ingressport} ${egressport} ${serviceport} ${adminport}

#测试版本需要修改egress fliter
if [ "$testversion" = true ] ; then
    python3 $INSTALL_PATH/tools/UpdateEgressFliter.py $INSTALL_PATH/tools/envoy_app.yaml ${appversion}
fi