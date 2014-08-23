#!/bin/bash

# Student Name Paul Harrison
# Student  no  x00111132
#  Deployment Ubuntu Project
# Date 25/07/2014

#functions to check if MYSQL is running

# Level 0 functions <--------------------------------------
#return 1 or 0  to calling function
# 1= running 0 = not running///error 

TIMESTAMP=`date '+%Y/%m/%d-%H:%M'`;

function isRunning {
PROCESS_NUM=$(ps -ef | grep "$1" | grep -v "grep" | wc -l)
if [ $PROCESS_NUM -gt 0 ] ; then
        echo $PROCESS_NUM
        return 1
else
        return 0
fi
}

function isMysqlRunning {
        isRunning mysqld
        return $?
}
#echos to  console and log result
isMysqlRunning
if [ "$?" -eq 1 ]; then
	  echo "Mysql process is Running At  $TIMESTAMP "

        echo "Mysql process is Running At  $TIMESTAMP "  >>  /home/testuser/log.log
else
        echo Mysql process is not Running
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

