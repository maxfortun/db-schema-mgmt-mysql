SWD=$( cd $( dirname "${BASH_SOURCE[0]}" ); pwd )

if [ -f $SWD/.mysqld.root-password ]; then
	MYSQL_ROOT_PASSWORD=$(cat $SWD/.mysqld.root-password)
fi

if [ -z $MYSQL_ROOT_PASSWORD ]; then
	MYSQL_ROOT_PASSWORD=$(openssl rand -hex 16 | tee $SWD/.mysqld.root-password)
fi

DOCKER_NAME=$(basename $(dirname $SWD))-example-mysqld
