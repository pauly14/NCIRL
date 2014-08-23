
#!/usr/bin/bash

# CHECKS IF APACHE2 SERVER IS RUNNING
# Student Name Paul Harrison
# Student  no  x00111132
#  Deployment Ubuntu Project
# Date 25/01/2014

# variable timestamp for echo to console and log file
TIMESTAMP=`date '+%Y/%m/%d-%H:%M'`;
# Level 0 functions <--------------------------------------


function isRunning {
PROCESS_NUM=$(ps -ef | grep "$1" | grep -v "grep" | wc -l)
if [ $PROCESS_NUM -gt 0 ] ; then
        echo $PROCESS_NUM
        return 1
else
        return 0
fi
}

# Level 1 functions <---------------------------------------

function isApacheRunning {
        isRunning apache2
        return $?
}

# Functional Body of monitoring script <----------------------------

isApacheRunning
if [ "$?" -eq 1 ]; then
#output results to logfiles with timestamp
 echo "Apache process is Running  At Date/Time -> $TIMESTAMP"

        echo "Apache process is Running  At Date/Time -> $TIMESTAMP" >> log.log
	ERRORCOUNT=0
else
# echo to log file if apache is NOT running
 	echo "Apache process is NOT Running  At Date/Time -> $TIMESTAMP"
        echo "Apache process is not Running  At Date/Time -> $TIMESTAMP" >> /home/testuser/log.log
>> log.log
        ERRORCOUNT=$((ERRORCOUNT+1))
#returns ERRORCOUNT to Calling script

fi

