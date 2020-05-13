import json
import sys

if len(sys.argv) != 3:
    print("Usage:%s [config_file] [appversion] " %(sys.argv[0]))
    sys.exit()

verison = sys.argv[2]

func = 'function envoy_on_request(request_handle) request_handle:headers():add("version","test") end'
func = func.replace("test",verison)
var = '{\
   "typed_config": {\
     "@type": "type.googleapis.com/envoy.config.filter.http.lua.v2.Lua",\
     "inline_code": ""\
   },\
   "name": "envoy.lua"\
}'

lua = json.loads(var)
lua["typed_config"]["inline_code"]=func


r = open(sys.argv[1],'r')
buf = json.load(r)
listeners = buf['static_resources']['listeners']
for listener in listeners:
    if listener['name'] == 'egress_listener' :
        listener["filter_chains"][0]["filters"][0]['typed_config']["http_filters"].append(lua)
        listener["filter_chains"][0]["filters"][0]['typed_config']["http_filters"].reverse()
w = open(sys.argv[1], 'w+')
json.dump(buf, w, sort_keys=True, indent=4, separators=(', ', ': '))
r.close()
w.close()

