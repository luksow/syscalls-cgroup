#!/bin/sh

# Tests checks if initial content of file is correct.

read first last <<< $(echo `cat $SYSCALLS_LIST_FILE | tail -n1`)
allow_expected=`seq 0 $last | tr '\n' ' '`'
'
allow_current=`cat $ALLOW_FILE`
echo $allow_expected > tmp1
echo $allow_current > tmp2
diff tmp1 tmp2
res=$?
rm tmp1 tmp2
if [ $res != 0 ]; then exit 1; fi

if [ `cat $DENY_FILE | wc -m`  != 1 ]; then exit 1; fi