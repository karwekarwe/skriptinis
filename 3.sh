#!/bin/bash


readarray -t procesai < <(ps -eo comm=,pid=,user=,etime=)

mkdir -p logs
rm -f logs/*.log

d=$(date +%F)
t=$(date +%H:%M:%S)

out="logs/$user-process-log-$d-$t.log"

if [ -n "$1" ]
	then 
	user="$1"
	{
	echo $d
	echo $t
	echo
	ps -u "$user" -o comm=,pid=,user=,etime= | awk '{print$1"\n"$2"\n"$3"\n"$4"\n"}'
	} > "$out" 

	cat "$out"

else

	for i in "${procesai[@]}"
	do 
	read proc pid user etime <<< "$i"
	out="logs/$user-process-log-$d-$t.log"
	if [[ ! -s "$out" ]]; then
		printf '%s\n%s\n\n' "$d" "$t" >> $out
	fi
	printf '%s\n%s\n%s\n%s\n\n' "$proc" "$pid" "$user" "$etime" >> $out 
	done

fi

echo "logs"
wc -l logs/*.log
cat logs/*.log | wc -l

read -p "Press Enter to finish..."
rm -rf logs
