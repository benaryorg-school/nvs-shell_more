#!/bin/sh

source ./functions.sh

printusage()
{
	echo "usage: $0 [-h] destination [sources]"
}

printhelp()
{
	printusage
	cat << "END"

        -h --help       this message

Writes sources into destination with delimiters.
END
}

if [ -z $1 ];then
	printusage
	exit 1
fi

for f in "$@";do
	case "$f" in
		"-h"|"--help")
			printhelp
			exit 0
		;;
	esac
done

DESTINATION="$1"
shift

for f in "$@";do
	if [ -r $f ];then
		echo --- $f --- >> $DESTINATION
		cat $f >> $DESTINATION
	else
		echo $f is not a file >&2
	fi
done

