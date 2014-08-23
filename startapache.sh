#!/usr/bin/bash
#start Apache Sevrer





TIMESTAMP=`date '+%Y/%m/%d-%H:%M'`;

sudo bash /etc/init.d/apache2 restart
# send message to console
echo "Apache restarted at  $TIMESTAMP"
#send message to log file
echo "Apache restarted at  $TIMESTAMP" >> /home/testuser/log.log


