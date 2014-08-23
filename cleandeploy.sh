#!/usr/bin/bash

# Student Name Paul Harrison
# Student  no  x00111132
#  Deployment Ubuntu Project
# Date 25/07/2014

#CLEAN DEPLOY

# Stop services
/etc/init.d/apache2 stop
/etc/init.d/mysql stop
# update
apt-get update
# remove and install apache2
apt-get -q -y remove apache2
apt-get -q -y install apache2
#
apt-get -q -y remove mysql-server mysql-client
echo mysql-server mysql-server/root_password password password | debconf-set-selections
echo mysql-server mysql-server/root_password_again password password | debconf-set-selections
apt-get -q -y install mysql-server mysql-client
# 
cd /tmp
mkdir $SANDBOX
cd $SANDBOX/

# Start services
/etc/init.d/apache2 start
/etc/init.d/mysql start
#
cat <<FINISH | mysql -uroot -ppassword
drop database if exists dbtest;
CREATE DATABASE dbtest;
GRANT ALL PRIVILEGES ON dbtest.* TO dbtestuser@localhost IDENTIFIED BY 'dbpassword';
use dbtest;
drop table if exists custdetails;
create table if not exists custdetails (
name         VARCHAR(30)   NOT NULL DEFAULT '',
address         VARCHAR(30)   NOT NULL DEFAULT ''
);
#insert into custdetails (name,address) values ('John Smith','Street Address'); select * from custdetails;
FINISH
#
cd /tmp
rm -rf $SANDBOX

