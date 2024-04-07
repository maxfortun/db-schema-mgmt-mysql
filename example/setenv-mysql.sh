SWD=$( cd $( dirname "${BASH_SOURCE[0]}" ); pwd )

MYSQL_HOSTNAME=$(cat $SWD/.mysqld.host 2>/dev/null || true)
MYSQL_USER=testuser

if [ -f $SWD/.mysqld.user-password ]; then
	MYSQL_PASSWORD=$(cat $SWD/.mysqld.user-password)
fi

if [ -z $MYSQL_PASSWORD ]; then
	MYSQL_PASSWORD=$(openssl rand -hex 16 | tee $SWD/.mysqld.user-password)
fi

MYSQL_DATABASE=testdb
