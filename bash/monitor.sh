#!/bin/bash
USER=$(whoami)
HOST=$(hostname)
SEEK=

if [ $# -eq 0 ]; then
	echo " ========================================================"
	echo " Poor man's monitor"
	echo " usage: watch -n 0.2 monitor.sh command1 command2 ..."
	echo " ========================================================"
else
	for var in "$@"
	do
	    SEEK="\|"$var$SEEK
	done
	echo $USER"@"$HOST"> swapon -s"
	swapon -s | \
	awk '{ print $3"\t"$1 }'
	echo " "
	echo $USER"@"$HOST"> top -bn 1"
	top -bn 1 | \
	grep "%MEM"$SEEK | \
	awk '{ print $1"\t"$9"\t"$10"\t" $5"\t"$6"\t"$7"\t" $12 }'
fi
