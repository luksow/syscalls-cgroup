#!/bin/sh

if [ `uname -m` == 'x86_64' ]
then
	./$SYSCALLS_DIR/close_x64notrace
	echo $?
	./$SYSCALLS_DIR/close_x64trace
	echo $?
	./$SYSCALLS_DIR/close_x86sysenter
	echo $?
	./$SYSCALLS_DIR/close_x86int0x80
	echo $?
else
	./$SYSCALLS_DIR/close_x86sysenter
	echo $?
	./$SYSCALLS_DIR/close_x86int0x80
	echo $?
fi