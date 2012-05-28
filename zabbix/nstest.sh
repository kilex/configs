#!/bin/bash
if [ $3 ]
then
	PREFIX="$3."
fi
RESULT=`host $PREFIX$1 $2 | grep has | awk '{print($4)}'`
if [ -z $RESULT ]
then
	echo 'error resolving';
else
	echo $RESULT
fi

exit;
