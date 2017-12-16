#!/usr/bin/env bash
# it's from https://pastebin.com/JPNqsthj
#this line limit the power to 80 watts for all cards
nvidia-smi -pl 80
 
#GPU clock will be reduced in 150, yes it is a negative value, this will save some power consumption and generate less heat
MY_CLOCK="-150"
#The most important part, Memory clock will be increased in 1150
MY_MEM="1150"
 
#fan speed
MY_FAN="55"
 
#this does the change for all GPUs for a rig with 6 cards [gpu0..gpu5]
for MY_DEVICE in {0..5}
do
        # Check if card exists
        if nvidia-smi -i $MY_DEVICE >> /dev/null 2>&1; then
                #This line is the one that enables the card to be customized/overclocked. very important!
                nvidia-settings -a "[gpu:$MY_DEVICE]/GPUPowerMizerMode=1"
                # set Fan speed
                nvidia-settings -a "[gpu:$MY_DEVICE]/GPUFanControlState=1"
                nvidia-settings -a "[fan:$MY_DEVICE]/GPUTargetFanSpeed=$MY_FAN"
                # set Grafics clock
                nvidia-settings -a "[gpu:$MY_DEVICE]/GPUGraphicsClockOffset[3]=$MY_CLOCK"
                # set Memory clock
                nvidia-settings -a "[gpu:$MY_DEVICE]/GPUMemoryTransferRateOffset[3]=$MY_MEM"
        fi
done
 
#for some reason gpu0 gives me issues when overclocked at the same level than the others (+1150)
#so basically I'm overclocking it less than the others. Use this part only if you have the same issues.
nvidia-settings -a "[gpu:0]/GPUGraphicsClockOffset[3]=-150"
nvidia-settings -a "[gpu:0]/GPUMemoryTransferRateOffset[3]=1050"
