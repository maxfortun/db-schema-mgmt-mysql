SWD=$( cd $( dirname "${BASH_SOURCE[0]}" ); pwd )

MYSQL_HOSTNAME=$(cat $SWD/.mysqld.host 2>/dev/null || true)
MYSQL_PORT=$(cat $SWD/.mysqld.port)
MYSQL_USER=testuser
MYSQL_PASSWORD=testpass
MYSQL_DATABASE=testdb
