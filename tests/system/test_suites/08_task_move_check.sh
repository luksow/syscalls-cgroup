#!/bin/sh

# Tests checks if permissions are properly interpreted when the task is moved
# from one cgroup to another.

mkdir "$CGROUP_DIR/empty_perm"

mkdir "$CGROUP_DIR/not_empty_perm1"
echo $SETUID_NO > "$CGROUP_DIR/not_empty_perm1/syscalls.deny"

mkdir "$CGROUP_DIR/not_empty_perm2"
echo $DUP_NO > "$CGROUP_DIR/not_empty_perm2/syscalls.deny"

echo 0 > "$CGROUP_DIR/empty_perm/tasks"
sh $SCRIPTS_DIR/all_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi

# empty -> not empty
echo 0 > "$CGROUP_DIR/not_empty_perm1/tasks"
sh $SCRIPTS_DIR/all_non_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi

# not empty -> not empty
echo 0 > "$CGROUP_DIR/not_empty_perm2/tasks"
sh $SCRIPTS_DIR/all_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_non_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi

# not empty -> empty
echo 0 > "$CGROUP_DIR/empty_perm/tasks"
sh $SCRIPTS_DIR/all_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi

echo 0 > "$CGROUP_DIR/tasks"
rmdir "$CGROUP_DIR/empty_perm"
rmdir "$CGROUP_DIR/not_empty_perm1"
rmdir "$CGROUP_DIR/not_empty_perm2"