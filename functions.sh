#!/bin/sh

isint()
{
	test $1 -eq $1 > /dev/null 2>&1 || return 1
	return 0
}

VERBOSE=false
debug()
{
	if $VERBOSE;then
		echo $@
	fi
}

