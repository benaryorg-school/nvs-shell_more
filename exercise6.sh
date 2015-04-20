#!/bin/bash

source ./functions.sh

printusage()
{
	echo "usage: $0 [-hv] [-p prefix] [-s suffix] directory ..."
}

printhelp()
{
	printusage
	cat << "END"

        -h --help       this message
        -v --verbose    verbose output

Moves files with pattern $prefix(xx)$suffix to $prefix(xx-1)$suffix.
END
}

if [ -z "$1" ] || [ ! -d "$1" ];then
	printusage
	exit 1
fi

PREFIX=loesung.
SUFFIX=.dir

while [ ! -z "$1" ];do
	case "$1" in 
		"-h"|"--help")
			printhelp
			exit 0
		;;
		"-v"|"--verbose")
			VERBOSE=true
		;;
		*)
			DIR=$1
		;;
	esac
	shift
done

last="00"
for z in {01..99};do
	if [ -e $DIR/$PREFIX$z$SUFFIX ];then
		debug mv $DIR/$PREFIX{$z,$last}$SUFFIX
		mv $DIR/$PREFIX{$z,$last}$SUFFIX
	fi
	last="$z"
done

