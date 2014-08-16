# paul harrison x00111132
#!/bin/sh
STATE=LISTEN
netstat -an | grep $STATE | grep tcp | wc -l
