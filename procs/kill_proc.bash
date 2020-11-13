#!/usr/bin/bash
trap "exit" INT TERM
trap "kill 0" EXIT

kill_proc_turbostat()
{
	pid=`ps -ef | grep [t]urbostat| awk '{print $2}'`
	echo "Killing $pid"
}


turbostat -c 0 > test.txt &

pid=`ps -ef | grep [t]urbostat | awk '{print $2}'`

echo "Started turbostat $pid"
sleep 10

kill_proc_turbostat
