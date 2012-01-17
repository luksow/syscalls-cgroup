#!/bin/sh

# Tests checks if subsystem reacts with error on incorrect string given.

echo 'foo' > $ALLOW_FILE # should fail
if [ $? == 0 ]; then exit 1; fi

echo 'foo' > $DENY_FILE # should fail
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
