#master deploy
# Student Name Paul Harrison
# Student  no  x00111132
#  Deployment Ubuntu Project
# Date 25/07/2014

# master deployment script
#this master deploy executes two  scripts
# the two scripts execute a clean environment and full deploy
# the two scripts in turn monitor all systems and log all errors and send
# emails of errors to administrators

#clean environment
source cleandeploy.sh

#full deploy
source deploy.sh

