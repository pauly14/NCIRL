#!/usr/bin/bash


# Student Name Paul Harrison
# Student  no  x00111132
#  Deployment Ubuntu Project
# Date 25/07/2014



TIMESTAMP=`date '+%Y/%m/%d-%H:%M'`;

sudo bash /etc/init.d/apache2 stop

echo "Apache stopped at  $TIMESTAMP"

echo "Apache stopped at  $TIMESTAMP" >> /home/testuser/log.log

 
