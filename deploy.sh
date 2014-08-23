#!/bin/bash

# full deploy with checking errors and deployment system
# Student Name Paul Harrison
# Student  no  x00111132
#  Deployment Ubuntu Project
# Date 25/07/2014

TIMESTAMP=`date '+%Y/%m/%d-%H:%M'`;
# make a sandbox in tmp directory in apache root
cd /tmp

echo "STARTING A FULL DEPLOY WITH MONITORING AT  $TIMESTAMP" >>  /home/testuser/deploy.log

echo "creating sandbox $TIMESTAMP" >>  /home/testuser/deploy.log
SANDBOX=sandbox_$RANDOM
mkdir $SANDBOX
cd $SANDBOX
# Make the process directories
echo "creating directory structure at $TIMESTAMP" >> /home/testuser/deploy.log


mkdir build
mkdir integrate
mkdir test
mkdir deploy

#BUILD Phase
cd build
echo "Cloning from Github $TIMESTAMP" >> /home/testuser/deploy.log


# GIT PULL from repo in Github
git clone https://github.com/pauly14/NCIRL.git

#zip  NCIRL repo as pre_integrate file
tar -czvf pre_integrate.tgz NCIRL

#move zipped file to Integrate folder
mv pre_integrate.tgz -t ../integrate

#rm -rf NCIRL

cd ..


  	# test if apache is running before continuing
	source /home/testuser/apacherunning.sh
	echo errorount = $ERRORCOUNT
	if [ "$ERRORCOUNT" -eq 0 ]; then
         echo "Apache process is Running At Date/Time -> $TIMESTAMP"

	else
        echo "Apache process is NOT Running: stopping deploy script before Integrate  At Date/Time -> $TIMESTAMP" >> log.log
        
	echo NOT coninuing. stopping Deploy: Apache not Running
	exit 0
	fi

#INTEGRATE

cd integrate
echo "running Integrate $TIMESTAMP" >> deploy.log

tar -zxvf pre_integrate.tgz
#rm pre_integrate.tgz

 # test if mysql is running before continuing
        source /home/testuser/mysqlrunning.sh
        
        if [ "$ERRORCOUNT" -eq 0 ]; then
         echo "MYSQL  process is Running At Date/Time -> $TIMESTAMP"

        else
        echo "MYSQL process is NOT Running: stopping deploy script before Creating Database  At Date/Time -> $TIMESTAMP" >> log.log

        echo NOT coninuing. stopping Creation of Database: MySQL not Running. Restart MYSQL
        exit 0
        fi




cd NCIRL
cat<<FINISH | mysql -uroot -ppassword
#if database exists then  delete
drop database if exists dbtest;

#create a new database
CREATE DATABASE dbtest;


#grant privilages to  database dbtest
GRANT ALL PRIVILEGES ON dbtest.* TO dbtestuser@localhost IDENTIFIED BY 'dbpassword';
# set dbtest as current database
use dbtest;
# if  table  custdetails exists then delete
drop table if exists custdetails;

#create new table with two fields name and address
#set datatype to varchar length 30 characters


create table if not exists custdetails (
name         VARCHAR(30)   NOT NULL DEFAULT '',
address         VARCHAR(30)   NOT NULL DEFAULT ''
);
# insert test data into table fields 


insert into custdetails (name,address) values ('Paul','Harrison');
FINISH
cd ..
tar -czvf pre_test.tgz NCIRL

# test to see folder current (only used in debugging)
#var=$(pwd)
#echo "The current working directory $var."

#move zipped file to test folder
mv pre_test.tgz -t ../test
  
#rm -rf NCIRL
cd ..


 # test if mysql is running before continuing
        source /home/testuser/mysqlrunning.sh

        if [ "$ERRORCOUNT" -eq 0 ]; then
         echo "MYSQL  process is Running At Date/Time -> $TIMESTAMP"

        else
        echo "MYSQL process is NOT Running: stopping TEST PHASE script before Testing Database  At Date/Time -> $TIMESTAMP" >> log.log

        echo NOT coninuing. stopping TestPhase  of Database: MySQL not Running. Restart MYSQL
        exit 0
        fi

#TEST PHASE
cd test
                          
tar -zxvf pre_test.tgz
#rm pre_test.tgz
cd NCIRL
cat<<FINISH | mysql -uroot -ppassword
use dbtest;
select*from custdetails;
FINISH
cd ..
tar -czvf pre_deploy.tgz NCIRL

var=$(pwd)
mv pre_deploy.tgz -t ../deploy
#rm -rf NCIRL
cd ..
#DEPLOY PHASE
cd deploy
tar -zxvf pre_deploy.tgz
#rm pre_deploy.tgz
cd NCIRL

 # test if apache is running before continuing
        source /home/testuser/apacherunning.sh
        echo errorount = $ERRORCOUNT
        if [ "$ERRORCOUNT" -eq 0 ]; then
         echo "No Errors Apache process is Running At Date/Time Deployment Contining -> $TIMESTAMP"

        else
        echo "Apache process is NOT Running: stopping final deploy script  At Date/Time -> $TIMESTAMP" >> log.log

        echo NOT coninuing. stopping Deploy: Apache not Running
        exit 0
        fi



#deploying to local apache server as deployment test
echo "deploying to Apache Server at $TIMESTAMP" >> deploy.log
cp Apache/www/* /var/www/
cp Apache/www/images/* /var/www/images
cp Apache/cgi-bin/* /usr/lib/cgi-bin/
chmod a+x /usr/lib/cgi-bin/*


