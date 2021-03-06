#!/bin/sh

# Tests checks if allow permissions are not propagated down the cgroups tree.

echo $SETUID_NO > $ALLOW_FILE
echo $DUP_NO > "$CGROUP_DIR/a1/syscalls.allow"

# in root
sh $SCRIPTS_DIR/all_but.sh $ALLOW_FILE
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all.sh $DENY_FILE

sh $SCRIPTS_DIR/all_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi

echo 0 > "$CGROUP_DIR/a2/tasks"
# in a2
sh $SCRIPTS_DIR/all_but.sh "$CGROUP_DIR/a2/syscalls.allow" $SETUID_NO
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all.sh "$CGROUP_DIR/a2/syscalls.deny" $SETUID_NO
if [ $? != 0 ]; then exit 1; fi

sh $SCRIPTS_DIR/all_non_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi

echo 0 > "$CGROUP_DIR/a1/tasks"
# in a1
sh $SCRIPTS_DIR/all_but.sh "$CGROUP_DIR/a1/syscalls.allow" $SETUID_NO
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all.sh "$CGROUP_DIR/a1/syscalls.deny" $SETUID_NO
if [ $? != 0 ]; then exit 1; fi

sh $SCRIPTS_DIR/all_non_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi

echo 0 > "$CGROUP_DIR/a1/b1/tasks"
# in b1
sh $SCRIPTS_DIR/all_but.sh "$CGROUP_DIR/a1/b1/syscalls.allow" $SETUID_NO $DUP_NO
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all.sh "$CGROUP_DIR/a1/b1/syscalls.deny" $SETUID_NO $DUP_NO
if [ $? != 0 ]; then exit 1; fi

sh $SCRIPTS_DIR/all_non_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_non_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi

echo 0 > "$CGROUP_DIR/a1/b2/tasks"
# in b2
sh $SCRIPTS_DIR/all_but.sh "$CGROUP_DIR/a1/b2/syscalls.allow" $SETUID_NO $DUP_NO
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all.sh "$CGROUP_DIR/a1/b2/syscalls.deny" $SETUID_NO $DUP_NO
if [ $? != 0 ]; then exit 1; fi

sh $SCRIPTS_DIR/all_non_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_non_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi

echo 0 > "$CGROUP_DIR/tasks"
rmdir "$CGROUP_DIR/a1/b1"
rmdir "$CGROUP_DIR/a1/b2"
rmdir "$CGROUP_DIR/a1"
rmdir "$CGROUP_DIR/a2"
