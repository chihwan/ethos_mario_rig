#!/bin/bash
#echo "WATCHDOG has bee started"
GPUCNT=$(($(cat /var/run/ethos/gpucount.file) - 1))
#echo "nGPU $GPUCNT"
limit=55
log_file=watchdog.log
crashed_gpu=crash_gpu
array=$(/opt/ethos/bin/stats|grep ^watts|tr "watts:" " ")
#echo $array[@]

restart=0
pointer=0
for i in $array
do
	currentPowerUsage=$i
	if [ "$currentPowerUsage" -lt "$limit" ]
	then
		echo "`date`: $array[@] \nCurrent power usage is $currentPowerUsage < $limit " | tee -a $log_file
		echo "$pointer" > $crashed_gpu
		restart=1
	fi
	pointer=$(($pointer + 1))
done
if [ "$restart" -eq 1 ]
then
	#echo $array[@]
	echo "`date`: restart miner" | tee -a $log_file
	sh /home/ethos/autotune.sh
	sleep 10 
	sudo r

fi
