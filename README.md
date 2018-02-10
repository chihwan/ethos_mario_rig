Mario's Ethos Configurations
- add configuration for zotac geforece gtx 1050ti dual silencer oc x 13 way x 1set
- add configuration for galaxy geforece gtx 1060 d5 6gb oc x 13 way x 2 sets
- deprecated watchdog.sh for auto restarting mining in case of low watt
- deprecated monitoring hash page, monitoring.html , auto refresh every 30 sec (deprecated)
- add dropcache to crontab
- add wachdog_r2.sh for auto restart in case of hardware crashed and invoke autotune.sh for modify overclock value -10(only for NVIDIA)
- add autotune.sh to tune overclock (mem) values (ONLY FOR NVIDIA)

NVIDIA Memory Autotune 
I recognized that the GPU goes down when it overtuned. For the test, I wrote very simple script that reduces overclocking value of memory on ETHOS especialy in local.conf file. 
For example, I assumed that your hostname is abc123, and have 13 ways NVIDIA GTC 1060. Then your local.conf file likes blow.
 cor abc123 000 000 000 000 000 000 000 000 000 000 000 000 000
 fan abc123 100 100 100 100 100 100 100 100 100 100 100 100 100
 pwr abc123  80  80  80  80  80  80  80  80  80  80  80  80  80
 mem abc123 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850 <- this mem line must be last line of local.conf

And then I assumed that first gpu(#0) of your GPUs crashed down. Because of its hardware error. That is normal. 
The watchdog_r2.sh script will catch the error of hardware by reading ethos hardware monitoring file. The values of mem line  will reduce overclocking value by -10. The local.conf will be modified like following.
\n
 cor abc123 000 000 000 000 000 000 000 000 000 000 000 000 000\n
 fan abc123 100 100 100 100 100 100 100 100 100 100 100 100 100\n
 pwr abc123  80  80  80  80  80  80  80  80  80  80  80  80  80\n
\# mem abc123 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850\n
 mem abc123 +840 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850 +850 \n

That's all.


How to Use AUTOTUNE.

Copy two shell files watchdog_r2.sh, autotune.sh to your home directory like /home/ethos.
And make sure of executable

$chmod +x watchdog_r2.sh autotune.sh

And you need to set scheduled up in cron daemon by crontab -e command.

$ sudo crontab -e

And add follwing command to the last line.

*/10 * * * * sh /home/ethos/watchdog_r2.sh

Now, the watchdog_r2.sh is scheduled to execute in every 10 minutes. 

