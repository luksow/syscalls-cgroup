#!/bin/sh

# Tests checks if subsystem reacts with error on out of range syscall number.

echo -1 > $ALLOW_FILE # should fail
if [ $? == 0 ]; then exit 1; fi

read first last <<< $(echo `cat $SYSCALLS_LIST_FILE | tail -n1`)

echo `expr $last + 1` > $DENY_FILE # should fail
if [ $? == 0 ]; then exit 1; fi

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