#!/bin/sh

# Tests checks if cgroup is removed properly.

echo 0 > "$CGROUP_DIR/tasks"
rmdir "$CGROUP_DIR/06/"

ls "$CGROUP_DIR/06/"
if [ $? == 0 ]; then exit 1; fi