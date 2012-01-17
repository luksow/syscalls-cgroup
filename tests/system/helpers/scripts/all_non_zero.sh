#!/bin/sh

# This script checks if all params are non-zero.

for i in $*
do
	if [ $i == 0 ]; then exit 1; fi
done

exit 0