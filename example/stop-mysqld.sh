#!/bin/bash -e

SWD=$(cd $(dirname $0); pwd)

. $SWD/setenv-mysqld.sh

docker stop $DOCKER_NAME
