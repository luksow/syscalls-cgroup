#!/bin/bash

# Runs every test $1 times and every syscall in tests $2 times.

for ((n=0; n<$1; n++))
do
	./time.sh ./getuid $2
	./time.sh ./setuid $2
	./time.sh ./chdir $2
	./time.sh ./read $2
done
