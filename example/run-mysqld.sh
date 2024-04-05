#!/bin/bash -e

SWD=$(cd $(dirname $0); pwd)

. $SWD/setenv-mysqld.sh

docker run -d --name $DOCKER_NAME -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD mysql:latest
