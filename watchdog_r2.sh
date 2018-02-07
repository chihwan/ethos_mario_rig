#!/bin/bash
#dalay=300
#echo "WATCHDOG will be started after $delay sec"
echo "WATCHDOG has bee started"
GPUCNT=$(($(cat /var/run/ethos/gpucount.file) - 1))
echo "nGPU $GPUCNT"
#sleep $delay
limit=55
log_file=watchdog.log
crashed_gpu=crash_gpu
#while :
#do
#array=$(/usr/bin/nvidia-smi -q -d POWER | grep "Power Draw" | sed 's/[^0-9,.]*//g' | cut -d . -f 1 |tr "\n" " ")
array=$(/opt/ethos/bin/stats|grep watts|tr "watts:" " ")
echo $array[@]

restart=0
pointer=0
for i in $array
do
	pointer=$(($pointer + 1))
	currentPowerUsage=$i
	if [ "$currentPowerUsage" -lt "$limit" ]
	then
		echo "`date`: $array[@] \nCurrent power usage is $currentPowerUsage < $limit " | tee -a $log_file
		echo "$pointer" > $crashed_gpu
		restart=1
	fi
done
if [ "$restart" -eq 1 ]
then
	echo $array[@]
	echo "`date`: restart miner" | tee -a $log_file
	#sudo r
	#sleep 300
fi
#sleep 180
#done
