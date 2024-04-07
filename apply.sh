#!/bin/bash -ex

file=$1
release=$2

if [ -z "$file" ]; then
	echo "Usage: $0 <file> <release>"
	echo " e.g.: $0 schema.sql 1.0.0"
	exit 1
fi

SWD=$(cd $(dirname $0); pwd)

$SWD/plan.sh $file $release > $file.changes
if grep "Nothing is modified" $file.changes >&2; then
	exit 0
fi

cat $SWD/pre_change.sql $file.changes $SWD/post_change.sql | tee $file.compiled

pre_apply=$file-hook-pre-apply
[ ! -x $pre_apply ] || $pre_apply

cat $file.compiled | $SWD/mysql.sh 

post_apply=$file-hook-post-apply
[ ! -x $post_apply ] || $post_apply

