#!/bin/bash

# Student Name Paul Harrison
# Student  no  x00111132
#  Deployment Ubuntu Project
# Date 25/07/2014

# test to show that a specif database exists
# hardcoded database name dbtest as this is the database  used in deployment  project

RESULT=`mysqlshow --user=root --password=password dbtest| grep -v Wildcard | grep -o dbtest`
echo $RESULT
if [ "$RESULT" == "dbtest" ]; then
    echo  Database Exists... Name $RESULT
else
	echo Database does not exist
fi
