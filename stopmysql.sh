#!/usr/bin/bash

# Student Name Paul Harrison
# Student  no  x00111132
#  Deployment Ubuntu Project
# Date 25/07/2014

TIMESTAMP=`date '+%Y/%m/%d-%H:%M'`;

sudo bash /etc/init.d/mysql stop
apt-get update
echo "MySQL stopped at  $TIMESTAMP"

echo "MYsQL stopped at  $TIMESTAMP" >> /home/testuser/log.log

