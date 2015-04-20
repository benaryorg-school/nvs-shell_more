#!/bin/sh

source ./functions.sh

printusage()
{
	echo "usage: $0 [-h] string ..."
}

printhelp()
{
	printusage
	cat << "END"

        -h --help       this message

Does print if the parameters are numeric or not.
END
}

if [ -z "$*" ];then
	printusage
	exit 1
fi

for i in "$@";do
	if [ "$i" == "-h" ] || [ "$i" == "--help" ];then
		printhelp
		exit 0
	fi
done

for i in "$@";do
	printf "$i\t\t\t"
	if ! isint "$i";then
		printf "not "
	fi
	echo "numeric"
done

