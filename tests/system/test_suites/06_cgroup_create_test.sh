#!/bin/sh

# Tests checks if cgroup is created properly.

echo $SETUID_NO > $DENY_FILE
echo $DUP_NO > $DENY_FILE

mkdir "$CGROUP_DIR/06"

echo $SETUID_NO > $ALLOW_FILE
echo $DUP_NO > $ALLOW_FILE

ls "$CGROUP_DIR/06/syscalls.allow"
if [ $? != 0 ]; then exit 1; fi
ls "$CGROUP_DIR/06/syscalls.deny"
if [ $? != 0 ]; then exit 1; fi

echo 0 > "$CGROUP_DIR/06/tasks"
sh $SCRIPTS_DIR/all_but.sh "$CGROUP_DIR/06/syscalls.allow" $SETUID_NO $DUP_NO
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all.sh "$CGROUP_DIR/06/syscalls.deny" $SETUID_NO $DUP_NO
if [ $? != 0 ]; then exit 1; fi

sh $SCRIPTS_DIR/all_non_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_non_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi