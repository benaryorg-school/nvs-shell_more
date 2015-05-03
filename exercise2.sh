#!/bin/sh

source ./functions.sh

printusage()
{
	echo "usage: $0 [-h] [-o file] [-d directory]"
}

printhelp()
{
	printusage
	cat << "END"

        -h --help       this message
        -o              output archive
        -d              input directory

Saves all Java source files in your home directory (or the provided directory)
into an archive.
END
}

DIRECTORY=~
OUTPUTFILE=javabackup.$(date +%0d-%0m-%0Y).tar

while [ ! -z "$1" ];do
	case "$1" in
		"-h"|"--help")
			printhelp
			exit 0
		;;
		"-d")
			shift
			if [ -z "$1" ];then
				printusage
				exit 1
			fi
			DIRECTORY="$1"
		;;
		"-o")
			shift
			if [ -z "$1" ];then
				printusage
				exit 1
			fi
			OUTPUTFILE="$1"
		;;
		*)
			printusage
			exit 1
		;;
	esac
	shift
done

FILES=$(find $DIRECTORY -regex '.+\.java' -mtime -8)
tar -cf $FILES $OUTPUTFILE > /dev/null 2>&1

