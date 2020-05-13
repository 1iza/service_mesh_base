import json
import sys

if len(sys.argv) != 3:
    print("Usage:%s [config_file] [servicename]" %(sys.argv[0]))
    sys.exit()
try:
    r = open(sys.argv[1],'r')
    buf = json.load(r)
    buf['srvname'] = sys.argv[2]

    w = open(sys.argv[1], 'w+')
    json.dump(buf, w, sort_keys=True, indent=4, separators=(', ', ': '))
    r.close()
    w.close()

except s:
    sys.exit()
