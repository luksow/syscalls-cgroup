#!/bin/sh

# This scripts mounts bare cgroup with syscalls subsystem. In arg1 should be
# passed a path, where cgroup root directory will be created. Default is /.

ROOT_PATH='/'

if [ $# == 1 ]
then
	if [ $1 == '--help' ]
	then
		echo "$0 [location for cgroup dir creation]"
		exit 0
	fi
	ROOT_PATH=$1
fi

cd $ROOT_PATH	# go to root
if [ $? != 0 ]; then exit 1; fi

mkdir -p cgroup # make root for cgroup
if [ $? != 0 ]; then exit 1; fi

mount -t tmpfs cgroup_root cgroup # mount cgroup
if [ $? != 0 ]; then exit 1; fi

cd cgroup # go there
mkdir -p syscalls # make root for syscalls cgroup
mount -t cgroup -osyscalls syscalls_root syscalls # mount syscalls cgroup