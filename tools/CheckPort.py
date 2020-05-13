import os
import sys

port = int(sys.argv[1])
interval = int(sys.argv[2]) 
while True:
    find_port= 'netstat -ltnp | grep %s' % port
    buf = os.popen(find_port)
    if buf.read() == "" :
        break
    else:
        port += interval

print(port)
