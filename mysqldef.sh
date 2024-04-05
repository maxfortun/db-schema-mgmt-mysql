#!/bin/bash -e

SWD=$(cd $(dirname $0); pwd)
[ ! -f $SWD/setenv-mysqldef.sh ] || . $SWD/setenv-mysqldef.sh
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

docker run -i --rm --name $SQLDEF_NAME $SQLDEF_REPO/$SQLDEF_NAME:$SQLDEF_VERSION mysqldef -h$MYSQL_HOSTNAME -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE "$@"

