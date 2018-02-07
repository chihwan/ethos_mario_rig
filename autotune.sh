#!/bin/bash
host=$(hostname)
crashed_gpu=crash_gpu
if [ -f "$crashed_gpu" ]
then
	echo "file exists"
	gpu=$(cat $crashed_gpu)
	echo $gpu
else
	echo "file not exists"
fi

echo $host
old_values=$(tail -n 1 local.conf)
echo $old_values
old_values="# $old_values" 
echo $old_values
line=$(tail -n 1 local.conf)
echo $line
#echo $line[@]

for ((i = 0; i < ${#line[@]}; ++i)); do
    # bash arrays are 0-indexed
    #position=$(( $i + 1 ))
    echo "aaa $i"
done

for i in $line
do
	#echo $i
	WATTS="$WATTS $i"
done
echo $WATTS
