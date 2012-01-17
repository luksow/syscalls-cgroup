#!/bin/sh

# Tests checks if unmounting of cgroup's filesystem is possible.

umount $CGROUP_DIR
exit $?