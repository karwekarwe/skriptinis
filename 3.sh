#!/bin/bash
mkdir -p logs
readarray -t procesai < <(ps -eo comm=,pid=,user=,etime=)

d=$(date +%F)
t=$(date +%H:%M:%S)

if [ -n "$1" ]
	then 
	user="$1"
	out="logs/$user-process-log-$d-$t.log"
	printf '%s\n%s\n\n' "$d" "$t" >> "$out"

	for i in "${procesai[@]}"
	do 
		read proc pid u etime <<< "$i"
		if [[ "$u" == "$user" ]]; then
			printf '%s\n%s\n%s\n%s\n\n' "$proc" "$pid" "$u" "$etime" >> "$out"
		fi
	done

	cat "$out"

else

	for i in "${procesai[@]}"
	do 
		read proc pid user etime <<< "$i"
		out="logs/$user-process-log-$d-$t.log"
		if [[ ! -s "$out" ]]; then
			printf '%s\n%s\n\n' "$d" "$t" >> "$out"
		fi
	printf '%s\n%s\n%s\n%s\n\n' "$proc" "$pid" "$user" "$etime" >> "$out" 
	done

fi

echo "logs"
wc -l logs/*.log
cat logs/*.log | wc -l

read -p "Press Enter to finish..."
rm -rf logs
