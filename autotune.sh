#!/bin/bash
host=$(hostname)
f_crashed_gpu=crash_gpu
dec=10
conf_file=local.conf
nlines=$(wc $conf_file|awk '{print $1-1}')
#echo 0 > crash_gpu
if [ -f "$f_crashed_gpu" ]
then
	#echo "file exists"
	gpu=$(cat $f_crashed_gpu)
	#echo $gpu

	old_values=$(tail -n 1 $conf_file)
	old_values="# $old_values" 
	line=$(tail -n 1 $conf_file)
	cnt=0
	gpu=$(($gpu+2))
	#echo $gpu
	for i in $line
	do
		if [ $cnt -gt 1  ]		
		then
			v=$i
			if [ $cnt -eq $gpu ] 
			then
				#echo "$(($i-$dec)) $gpu is same"
				v=+$(($i-$dec))
			fi
			WATTS="$WATTS $v"
		fi
	       	cnt=$(($cnt + 1))
	done

	WATTS="mem $host $WATTS"
	echo "TEST" $WATTS
	#echo $WATTS >> local.conf

	head -n $nlines $conf_file > temp.f
	#wc $conf_file |awk '{print $1-1}'|xargs head $conf_file -n > $conf_file
	#echo $contents > local_2.conf
	echo $old_values >> temp.f
	echo $WATTS >> temp.f
	rm $conf_file
	mv temp.f $conf_file
	rm $f_crashed_gpu
else
	echo "file not exists, there is nothing to do"
fi
