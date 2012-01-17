#!/bin/sh

# Tests checks if allow permissions is denied when syscall is denied in superior
# cgroup.

mkdir "$CGROUP_DIR/12"
echo $SETUID_NO > $DENY_FILE

echo $SETUID_NO > "$CGROUP_DIR/12/syscalls.allow" # should fail
if [ $? == 0 ]; then exit 1; fi

sh $SCRIPTS_DIR/all_but.sh "$CGROUP_DIR/12/syscalls.allow" $SETUID_NO
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all.sh "$CGROUP_DIR/12/syscalls.deny" $SETUID_NO
if [ $? != 0 ]; then exit 1; fi

echo 0 > "$CGROUP_DIR/12/tasks"
sh $SCRIPTS_DIR/all_non_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi

echo 0 > "$CGROUP_DIR/tasks"
rmdir "$CGROUP_DIR/12"
echo $SETUID_NO > $ALLOW_FILE