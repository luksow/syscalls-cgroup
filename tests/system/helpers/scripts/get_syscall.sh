#!/bin/sh

# This script fetches syscall number based on name.

read first last <<< $(echo `sh $SCRIPTS_DIR/get_syscalls.sh | grep -w $1`)
echo $last