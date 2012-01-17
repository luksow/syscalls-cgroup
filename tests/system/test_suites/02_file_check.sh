#!/bin/sh

# Tests checks if all subsystem specific files are created.

ls $ALLOW_FILE
if [ $? != 0 ]; then exit 1; fi
ls $DENY_FILE
if [ $? != 0 ]; then exit 1; fi