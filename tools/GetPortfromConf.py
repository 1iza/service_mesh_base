import json
import sys
if len(sys.argv) < 3:
    sys.exit()
try:
    s = open(sys.argv[1],'r')
    buf = json.load(s)
    if sys.argv[2] == 'listeners' :
        listeners = buf['static_resources']['listeners']
        for item in listeners:
            if item['name'] == sys.argv[3] :
                print(item['address']['socket_address']['port_value'])
    elif sys.argv[2] == 'clusters' :
        clusters = buf['static_resources']['clusters']
        for item in clusters:
            if item['name'] == sys.argv[3] :
                print(item['load_assignment']['endpoints'][0]['lb_endpoints'][0]['endpoint']['address']['socket_address']['port_value'])
    elif sys.argv[2] == 'logpath' :
        listeners = buf['static_resources']['listeners']
        for item in listeners:
            if item['name'] == sys.argv[3] :
                chains = item['filter_chains']
                for chain in chains:
                    for filters in chain['filters']:
                        if filters['name'] == 'envoy.http_connection_manager':
                            logs = filters['typed_config']['access_log']
                            for log in logs:
                                if log['name'] == 'envoy.file_access_log':
                                    print(log['config']['path'])
    elif sys.argv[2] == 'admin':
        print(buf['admin']['address']['socket_address']['port_value'])

except :
    sys.exit()

