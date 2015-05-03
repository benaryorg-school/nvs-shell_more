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
        -p --prefix     set prefix
        -s --suffix     set suffix

Moves files with pattern $prefix(xx)$suffix to $prefix(xx-1)$suffix.
END
}

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
		"-p"|"--prefix")
			shift
			if [ -z "$1" ];then
				printusage
				exit 1
			fi
			PREFIX="$1"
		;;
		"-s"|"--suffix")
			shift
			if [ -z "$1" ];then
				printusage
				exit 1
			fi
			SUFFIX="$1"
		;;
		*)
			if [ ! -z "$DIR" ] || [ -z "$1" ] || [ ! -d "$1" ];then
				printusage
				exit 1
			fi
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

