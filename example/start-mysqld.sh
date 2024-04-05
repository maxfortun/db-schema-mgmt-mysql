#!/bin/bash -e

SWD=$(cd $(dirname $0); pwd)

. $SWD/setenv-mysqld.sh
. $SWD/setenv-mysql.sh

DOCKER_RUN_ARGS=( -d )
DOCKER_RUN_ARGS+=( --rm )
DOCKER_RUN_ARGS+=( -p $MYSQL_PORT:3306 )
DOCKER_RUN_ARGS+=( --name $DOCKER_NAME ) 
DOCKER_RUN_ARGS+=( -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD )
DOCKER_RUN_ARGS+=( -e MYSQL_USER=$MYSQL_USER )
DOCKER_RUN_ARGS+=( -e MYSQL_PASSWORD=$MYSQL_PASSWORD )
DOCKER_RUN_ARGS+=( -e MYSQL_DATABASE=$MYSQL_DATABASE )

docker run "${DOCKER_RUN_ARGS[@]}" mysql:latest

docker inspect --format '{{ .NetworkSettings.IPAddress }}' $DOCKER_NAME > $SWD/.mysqld.host

