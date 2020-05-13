import json
import sys
if len(sys.argv) != 2:
    sys.exit()
try:
    s = open(sys.argv[1], 'r')
    buf = json.load(s)
    print(buf['srvname'])

except :
    sys.exit()