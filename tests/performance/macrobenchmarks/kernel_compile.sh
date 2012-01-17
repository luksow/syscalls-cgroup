#!/bin/bash

# Compiles kernel in four jobs (make -j4) $1 times.

rm -rf linux-3.1.6
tar -xf linux-3.1.6.tar.bz2
cp .config linux-3.1.6/
cd linux-3.1.6

TIMEFORMAT='%3lR %3lU %3lS'
for ((n=0; n<$1; n++))
do
	times=$( { time make -j4 > /dev/null 2>&1 ;} 2>&1 )
	read real user sys <<< $(echo $times)

	tmp='60 *'`echo $real | tr 'm' '+' | tr -d 's'`
	real=`python -c "print('%0.3f' % ($tmp))"`

	tmp='60 *'`echo $user | tr 'm' '+' | tr -d 's'`
	user=`python -c "print('%0.3f' % ($tmp))"`

	tmp='60 *'`echo $sys | tr 'm' '+' | tr -d 's'`
	sys=`python -c "print('%0.3f' % ($tmp))"`

	echo $real $user $sys
	make clean > /dev/null
done
cd ..
rm -rf linux-3.1.6