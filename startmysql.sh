#!/usr/bin/bash

# Student Name Paul Harrison
# Student  no  x00111132
#  Deployment Ubuntu Project
# Date 25/07/2014

#restart MYSQL Sevrer

TIMESTAMP=`date '+%Y/%m/%d-%H:%M'`;

sudo bash /etc/init.d/mysql restart

echo "MySql restarted at  $TIMESTAMP"

echo "MySql  restarted at  $TIMESTAMP" >> /home/testuser/log.log

