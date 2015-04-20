#!/bin/bash

source ./functions.sh

printusage()
{
	echo "usage: $0 [-hv] file [algorithm list] ..."
}

printhelp()
{
	printusage
	cat << "END"

        -h --help       this message
        -v --verbose    verbose output

Tests which algorithm of a list works best. Default are xz, bzip2, gzip.
END
}

parse_algorithms()
{
	while [ ! -z "$1" ];do
		x=$(which $1 2> /dev/null)
		if [ $? -eq 0 ];then
			echo $x
		fi
		shift
	done
}

if [ -z "$1" ] || [ ! -f "$1" ];then
	printusage
	exit 1
fi

if [ ! -f "$1" ];then
	printusage
	exit 1
fi
FILE="$1"
shift

ALGORITHMS="xz bzip2 gzip "

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
			ALGORITHMS+="$1 "
		;; 
	esac
	shift
done

LIST=$(parse_algorithms $ALGORITHMS | sort -u)

f=$(tempfile)
rm $f
mkdir $f

max=0
maxf=""

for a in $LIST;do
	debug
	debug trying $a
	debug copying
	cp $FILE $f
	debug compressing
	$a $f/$FILE
	debug removing
	nf=$f/$FILE.*
	size=$(du $nf | cut -f1)
	debug size=$size
	if [ $size -lt $max ] || [ $max -eq 0 ];then
		max=$size
		maxf=$f/.$(basename $f/$FILE.*)
		mv $nf $maxf
	else
		rm -f $nf
	fi
done

debug $maxf was the best
cp $maxf ${maxf##$f/.}

rm -rf $f

