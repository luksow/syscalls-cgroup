#!/bin/sh

# Tests checks if permissions are correct after fork in cgroup.

mkdir "$CGROUP_DIR/09"
echo $SETUID_NO > "$CGROUP_DIR/09/syscalls.deny"
echo $DUP_NO > "$CGROUP_DIR/09/syscalls.deny"
echo 0 > "$CGROUP_DIR/09/tasks"

(sh $SCRIPTS_DIR/all_non_zero.sh `sh $SETUID`)
if [ $? != 0 ]; then exit 1; fi
(sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`)
if [ $? != 0 ]; then exit 1; fi
(sh $SCRIPTS_DIR/all_non_zero.sh `sh $DUP`)
if [ $? != 0 ]; then exit 1; fi
(sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`)
if [ $? != 0 ]; then exit 1; fi

echo 0 > "$CGROUP_DIR/tasks"

rmdir "$CGROUP_DIR/09"