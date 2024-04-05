#!/bin/bash -e

SWD=$(cd $(dirname $0); pwd)
[ ! -f $SWD/setenv-mysql.sh ] || . $SWD/setenv-mysql.sh
[ ! -f $SWD/setenv-mysqldef.sh ] || . $SWD/setenv-mysqldef.sh

MISSING=()
for var in MYSQL_HOSTNAME MYSQL_USERNAME MYSQL_PASSWORD MYSQL_DB; do
	val=${!var}
	[ -z "$val" ] || continue
	MISSING+=( $var )
done

if [ -n "${MISSING[*]}" ]; then
	echo "Missing env vars: ${MISSING[@]}"
	echo "export them into the env or set them in $SWD/setenv-mysql.sh"
	exit 1
fi

docker run -i --rm --name $SQLDEF_NAME $SQLDEF_REPO/$SQLDEF_NAME:$SQLDEF_VERSION mysqldef -h$MYSQL_HOSTNAME -u$MYSQL_USERNAME -p$MYSQL_PASSWORD $MYSQL_DB "$@"

