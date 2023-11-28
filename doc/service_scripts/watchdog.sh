#!/bin/sh
#print "Free/Total memory: " int(mem_free/1024) "/" int(mem_total/1024) " MiB (" (mem_free_p) "%)";     	
while :
do
	echo "Press [CTRL+C] to stop.."
	sleep 15

	awk '{
	    if (/MemFree:/) {mem_free=$2};
	    if (/MemTotal:/) {mem_total=$2};
	    if (mem_free && mem_total)
	      {
		mem_free_p = int(mem_free * 100 / mem_total);
	      	if (mem_free_p < 7){
	      	        print "Free/Total memory: " int(mem_free/1024) "/" int(mem_total/1024) " MiB (" (mem_free_p) "%)";
	      		system("pkill flutter");
	      	}
	      	exit
	      }
	  }' /proc/meminfo   
done
