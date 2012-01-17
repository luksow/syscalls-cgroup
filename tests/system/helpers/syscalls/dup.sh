#!/bin/sh

if [ `uname -m` == 'x86_64' ]
then
	./$SYSCALLS_DIR/dup_x64notrace
	echo $?
	./$SYSCALLS_DIR/dup_x64trace
	echo $?
	./$SYSCALLS_DIR/dup_x86sysenter
	echo $?
	./$SYSCALLS_DIR/dup_x86int0x80
	echo $?
else
	./$SYSCALLS_DIR/dup_x86sysenter
	echo $?
	./$SYSCALLS_DIR/dup_x86int0x80
	echo $?
fi