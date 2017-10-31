# db_initialize
Small docker image for initializing databases (mongo and mysql)

Image includes mongo-tools and mysql-clients packages, as well as dockerize binary and a small wrapper script
around dockerize called "dockerize.sh". The wrapper script passes all the input arguments to dockerize and then if
dockerize exits successfully, it will spawn a netcat listener on port 8080.

The listener can be used as ann argument to dockerize ( example: -wait tcp://init:8080 ) so that containers
that depends on both a database, as well as some initial data can check port 8080 to see if the database has been
properly initialized.

Here's an example docker-compose stanza that waits for mongodb to come up, loads it with data from a bind mount.
Upon successful exit the netcat takes over and list has a listener parked on port 8080 that can be polled by other
containers:

~~~
services:
  mongoinit:
    image: kbase/db_initialize:latest
    volumes:
      - ./shock.mongodump:/mnt/shock.mongodump
    entrypoint:
      - "/kb/deployment/bin/dockerize.sh"
      - "-wait"
      - "tcp://mongo:27017"
      - "-timeout"
      - "120s"
      - "mongorestore"
      - "--host"
      - "mongo"
      - "/mnt/shock.mongodump"
    depends_on: [ "mongo" ]
  mongo:
    image: mongo:2
    ports:
      - "27017:27017"
secrets:
~~~
