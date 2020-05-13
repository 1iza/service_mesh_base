import json
import sys

if len(sys.argv) != 6:
    print("Usage:%s [config_file] [envoy_ingress_port] [envoy_egress_port] [app_port] [admin_port]" %(sys.argv[0]))
    sys.exit()
try:
    r = open(sys.argv[1],'r')
    buf = json.load(r)
    buf['admin']['address']['socket_address']['port_value'] = int(sys.argv[5])
    listeners = buf['static_resources']['listeners']
    for item in listeners:
        if item['name'] == 'ingress_listener' :
            item['address']['socket_address']['port_value'] = int(sys.argv[2])
        if item['name'] == 'egress_listener':
            item['address']['socket_address']['port_value'] = int(sys.argv[3])
    clusters = buf['static_resources']['clusters']
    for item in clusters:
        if item['name'] == 'local_app' :
            item['load_assignment']['endpoints'][0]['lb_endpoints'][0]['endpoint']['address']['socket_address']['port_value'] = int(sys.argv[4])

    w = open(sys.argv[1], 'w+')
    json.dump(buf, w, sort_keys=True, indent=4, separators=(', ', ': '))
    r.close()
    w.close()

except :
    sys.exit()
