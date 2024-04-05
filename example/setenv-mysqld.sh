SWD=$( cd $( dirname "${BASH_SOURCE[0]}" ); pwd )

if [ -f $SWD/.mysqld.root-password ]; then
	MYSQL_ROOT_PASSWORD=$(cat $SWD/.mysqld.root-password)
fi

if [ -z $MYSQL_ROOT_PASSWORD ]; then
	MYSQL_ROOT_PASSWORD=$(openssl rand -hex 16 | tee $SWD/.mysqld.root-password)
fi

if [ -f $SWD/.mysqld.port ]; then
	MYSQL_PORT=$(cat $SWD/.mysqld.port)
fi

if [ -z $MYSQL_PORT ]; then
	netstat -p tcp -n|awk '{ print $4 }'|sed 's/^.*\.//g'|sort -fu > $SWD/.mysqld.used-ports
	for ((port=40000; port<=49999; port++)); do
		if ! grep -q ^$port $SWD/.mysqld.used-ports; then
			MYSQL_PORT=$(echo $port | tee $SWD/.mysqld.port)
			break
		fi
	done
fi

DOCKER_NAME=$(basename $(dirname $SWD))-example-mysqld
