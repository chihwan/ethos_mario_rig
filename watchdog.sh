#!/bin/sh
#WATCHDOG for NVIDIA GPU ethminer
#THIS IS MODIFIED VERSION OF 
#sleep 60
limit=55
log_file=watchdog.log
while :
do
array=$(/usr/bin/nvidia-smi -q -d POWER | grep "Power Draw" | sed 's/[^0-9,.]*//g' | cut -d . -f 1 |tr "\n" " ")
#echo $array[@]
restart=0
for i in $array[@]
do
  if [ $i != "[@]" ]
  then
        currentPowerUsage=$i
        if [ "$currentPowerUsage" -lt "$limit" ]
        then
                echo "`date`: Current power usage is $currentPowerUsage < $limit " | tee -a $log_file
                restart=1
        fi
        sleep 1
  fi
done

if [ "$restart" -eq 1 ]
then
        echo $array[@]
        echo "`date`: restart miner" | tee -a $log_file
        minestop; minestart
        sleep 180
fi
sleep 180
done
