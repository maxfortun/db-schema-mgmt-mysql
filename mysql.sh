#!/bin/bash -e

SWD=$(cd $(dirname $0); pwd)
[ ! -f $SWD/setenv-mysql.sh ] || . $SWD/setenv-mysql.sh
[ ! -f setenv-mysql.sh ] || . setenv-mysql.sh

MISSING=()
for var in MYSQL_HOSTNAME MYSQL_USER MYSQL_PASSWORD MYSQL_DATABASE; do
	val=${!var}
	[ -z "$val" ] || continue
	MISSING+=( $var )
done

if [ -n "${MISSING[*]}" ]; then
	echo "Missing env vars: ${MISSING[@]}"
	echo "export them into the env or set them in $SWD/setenv-mysql.sh"
	exit 1
fi

DOCKER_RUN_ARGS=( -i )
DOCKER_RUN_ARGS+=( --rm )

if [[ -t 0 ]]; then
	DOCKER_RUN_ARGS+=( -t )
fi

docker run "${DOCKER_RUN_ARGS[@]}" mysql:latest mysql --protocol=TCP -h$MYSQL_HOSTNAME -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE "$@"
