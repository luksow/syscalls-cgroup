#!/bin/sh

# This scripts runs all the tests from test_suites directory.
# The name pattern of the suite should be XX_some_description.sh where XX is
# ordinal number. The script should be sh script and return 0 on success, non-0
# otherwise.

SCRIPTS_DIR='helpers/scripts/' export SCRIPTS_DIR
SYSCALLS_DIR='helpers/syscalls/' export SYSCALLS_DIR
CGROUP_DIR='/cgroup/syscalls/' export CGROUP_DIR
ALLOW_FILE=$CGROUP_DIR/'syscalls.allow' export ALLOW_FILE
DENY_FILE=$CGROUP_DIR/'syscalls.deny' export DENY_FILE

CLOSE="$SYSCALLS_DIR/close.sh" export CLOSE
CLOSE_NO=`sh $SCRIPTS_DIR/get_syscall.sh close` export CLOSE_NO
DUP="$SYSCALLS_DIR/dup.sh" export DUP
DUP_NO=`sh $SCRIPTS_DIR/get_syscall.sh dup` export DUP_NO
FORK="$SYSCALLS_DIR/fork.sh" export FORK
FORK_NO=`sh $SCRIPTS_DIR/get_syscall.sh fork` export FORK_NO
SETUID="$SYSCALLS_DIR/setuid.sh" export SETUID
SETUID_NO=`sh $SCRIPTS_DIR/get_syscall.sh setuid` export SETUID_NO

# cleanup & preparation
echo 'Compiling helpers...'
make -sC $SYSCALLS_DIR clean
if [ `uname -m` == 'x86_64' ]
then
	make -sC $SYSCALLS_DIR all
else
	make -sC $SYSCALLS_DIR x86
fi
sh $SCRIPTS_DIR/get_syscalls.sh > syscalls_list
SYSCALLS_LIST_FILE='./syscalls_list' export SYSCALLS_LIST_FILE

echo 'Executing tests...'
for i in `ls test_suites`
do
	sh 'test_suites'/$i > /dev/null 2>&1
	if [ $? == 0 ]
	then
		echo $i				'[OK]'
	else
		echo $i				'[FAILED]'
		echo 'Cancelling execution!'
		exit -1
	fi
done

# cleanup
rm ./syscalls_list
make -sC $SYSCALLS_DIR clean

echo 'Done!'