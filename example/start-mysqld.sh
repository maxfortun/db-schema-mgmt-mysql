#!/bin/bash -e

SWD=$(cd $(dirname $0); pwd)

. $SWD/setenv-mysqld.sh

docker run -d --rm -p 127.0.0.1:$MYSQL_PORT:3306 --name $DOCKER_NAME -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD mysql:latest
