#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Required dump file name as argument #1"
	exit 22
fi

DRIVEDEV=/dev/cdrom

if [ ! -f $DRIVEDEV ]; then
	echo "Unable to access $DRIVEDEV"
	exit 6
fi
BLKSIZE=$( isoinfo -d -i $DRIVEDEV | grep -i 'block size' | awk '{ print $5 }' )
VOLSIZE=$( isoinfo -d -i $DRIVEDEV | grep -i 'volume size' | awk '{ print $4 }' )

touch $1
if [ $? -ne 0 ]; then
	echo "File creation error"
	exit 13
fi

echo "Dumping from $DRIVEDEV to file $1 with block size $BLKSIZE and volume size $VOLSIZE"
pause

dd if=$DRIVEDEV of=$1.iso bs=$BLKSIZE count=$VOLSIZE status=progress

RC=$?
if [ $RC -ne 0 ]; then
	echo "Dump error"
	exit $RC
fi

echo "done"
