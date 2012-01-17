#!/bin/sh

# Tests checks if mounting of cgroup's filesystem is possible.

sh $SCRIPTS_DIR/make_cgroupfs.sh
exit $?