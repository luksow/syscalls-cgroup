#!/bin/bash

# Reimplementation of time bash builtin command so that it's easier to use.

TIMEFORMAT='%3lR %3lU %3lS'

times=$( { time $@ > /dev/null; } 2>&1 )
read real user sys <<< $(echo $times)
#echo $real $user $sys

tmp='60 *'`echo $real | tr 'm' '+' | tr -d 's'`
real=`python -c "print('%0.3f' % ($tmp))"`

tmp='60 *'`echo $user | tr 'm' '+' | tr -d 's'`
user=`python -c "print('%0.3f' % ($tmp))"`

tmp='60 *'`echo $sys | tr 'm' '+' | tr -d 's'`
sys=`python -c "print('%0.3f' % ($tmp))"`

echo $real $user $sys

