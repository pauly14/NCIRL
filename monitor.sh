#!/bin/bash
# Student Name Paul Harrison
# Student  no  x00111132
#  Deployment Ubuntu Project
# Date 25/07/2014
# monitor of system

TIMESTAMP=`date '+%Y/%m/%d-%H:%M'`;


ADMINISTRATOR=pauly.harrison01@gmail.com
MAILSERVER=mail1.gmail.com

# Level 1 functions <---------------------------------------

#test if apache is running
function isApacheRunning {
        isRunning apache2
        return $?
}

#test if Apache is listening
function isApacheListening {
        isTCPlisten 80
        return $?
}

function isApacheRemoteUp {
        isTCPremoteOpen 127.0.0.1 80
        return $?
}
# returns 1 or 0 to calling function
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


# test if TCP listening
# returns 0 to calling function
function isTCPlisten {
TCPCOUNT=$(netstat -tupln | grep tcp | grep "$1" | wc -l)
if [ $TCPCOUNT -gt 0 ] ; then
        return 1
else
        return 0
fi
}

function isTCPremoteOpen {
timeout 1 bash -c "echo >/dev/tcp/$1/$2" && return 1 ||  return 0

}

ERRORCOUNT=0

# Functional Body of monitoring script <----------------------------
#function to check if apache is up and running or echo errors to log file
isApacheRunning
if [ "$?" -eq 1 ]; then
         echo "Apache process is Running At Date/Time -> $TIMESTAMP"

        echo "Apache process is Running At Date/Time -> $TIMESTAMP" >> log.log
	echo -----------------------------------------------------------------
else
	echo "Apache process is NOT Running At Date/Time -> $TIMESTAMP" >> log.log
        ERRORCOUNT=$((ERRORCOUNT+1))
fi

isApacheListening
if [ "$?" -eq 1 ]; then
        echo Apache is Listening
	 echo "Remote Apacheis listening  at $TIMESTAMP" >> /home/testuser/log.log
else
        echo Apache is not Listening
        ERRORCOUNT=$((ERRORCOUNT+1))
fi
# chech if apache is up or echo errors
isApacheRemoteUp
if [ "$?" -eq 1 ]; then
        echo  Apache TCP port is up
	
	echo "Apache TCP port is up at $TIMESTAMP" >> /home/testuser/log.log

else
        echo  Apache TCP port is down
	 echo " Apache TCP port is down at $TIMESTAMP" >> /home/testuser/log.log	        
ERRORCOUNT=$((ERRORCOUNT+1))
fi
if  [ $ERRORCOUNT -gt 0 ]
then
#send an email to admin pauly.harrison01@gmail.com if any apache errors
        ruby mailer.rb "pauly.harrison01@gmail.com" "apache down" "There is a Problem with Apache Server"
	 echo "EMAIL sent to Admin with Apache error message at $TIMESTAMP" >> /home/testuser/log.log

fi


