#!/bin/sh

# This script fetches syscalls with their corresponding numbers from given in
# arg1 path to Linux source. If arg1 is empty, default path is assumed.

LINUX_PATH='/usr/src/linux'

if [ $# == 1 ]
then
	if [ $1 == '--help' ]
	then
		echo "$0 [linux source path]"
		exit 0
	fi
	LINUX_PATH=$1
fi

LINUX_ARCH_PATH=$LINUX_PATH/arch/x86/include/asm

ls $LINUX_ARCH_PATH > /dev/null 2>&1
if [ $? != 0 ]
then
	echo "$0: $LINUX_PATH: Invalid path to Linux source"
	exit 1
fi

if [ `uname -m` == 'x86_64' ]
then
	grep '#define __NR_' $LINUX_ARCH_PATH/unistd_64.h | sed 's/#define __NR_//g' | tr '\t' ' '
else
	grep '#define __NR_' $LINUX_ARCH_PATH/unistd_32.h | sed 's/#define __NR_//g' | tr '\t' ' '
fi