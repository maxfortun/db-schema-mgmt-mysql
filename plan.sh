#!/bin/bash -e

file=$1
release=$2

if [ -z "$file" ]; then
	echo "Usage: $0 <file> <release>"
	echo " e.g.: $0 schema.sql 1.0.0"
	exit 1
fi

SWD=$(cd $(dirname $0); pwd)

function restore_head {
	git checkout HEAD $file
	git stash pop
}

if [ -n "$release" ]; then
	trap restore_head EXIT
	git stash
	git checkout $release $file
fi

$SWD/mysqldef.sh --dry-run < $file 
