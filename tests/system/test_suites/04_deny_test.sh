#!/bin/sh

# Tests checks if denying works properly.

echo $SETUID_NO > $DENY_FILE

sh $SCRIPTS_DIR/all_but.sh $ALLOW_FILE $SETUID_NO
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all.sh $DENY_FILE $SETUID_NO
if [ $? != 0 ]; then exit 1; fi

sh $SCRIPTS_DIR/all_non_zero.sh `sh $SETUID`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $CLOSE`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $DUP`
if [ $? != 0 ]; then exit 1; fi
sh $SCRIPTS_DIR/all_zero.sh `sh $FORK`
if [ $? != 0 ]; then exit 1; fi