#!/bin/bash
#
# Script that wraps the the dockerize command, and then sets up a netcat listener
# on port 8080 to mark that it has completed. This is a hack to deal with race conditions
# between a container that initializes a database, and the apps that require the database
# to be initialized already. Apps the depend on the initialization step can check for
# a listener on port 8080 from this image as a signal that the database has completed
# initialization
#
# sychan@lbl.gov

/kb/deployment/bin/dockerize $@
echo "Starting listener on port 8080 to signal that initialization is complete"
nc -lk 8080
