#!/bin/bash
source shrc
trap "exit" INT TERM
trap "kill 0" EXIT
echo always > /sys/kernel/mm/transparent_hugepage/enabled
echo 0 > /proc/sys/vm/nr_hugepages

cat /proc/meminfo
echo 3 > /proc/sys/vm/drop_caches
ulimit -s unlimited
ulimit -c unlimited
ulimit -l 20971521
#echo 0 > /proc/sys/kernel/randomize_va_space
#source shrc

cores=32
threads=$((2*${cores}))
procs=$threads
config=arrowhead-revA-2P-${cores}C${threads}T.cfg

echo "Cores:$cores"
echo "Threads:$threads"
echo "procs:$procs"
echo "config:$config"
ls "config/$config"

rm -rf terminate.txt
#./agt_internal -pmlogall -pmstopcheck -pmperiod=1000 -pmoutput=agm_cores${cores}_${bench}_agm_7763.csv &
turbostat -c 0 > tstat_cores${cores}_${bench}_agm_7763.csv &
sleep 3

 echo "runspec -c ${config}  -I -l --rate ${procs}  --iterations 1 --size ref --tune base  int"
 runspec -c ${config}  -I -l --rate ${procs}  --iterations 1 --size ref --tune base  int
touch terminate.txt
 echo "runspec -c ${config}  -I -l --rate ${procs}  --iterations 1 --size ref --tune base  --action clean int"
runspec -c ${config}  -I -l --rate ${procs}  --iterations 1 --size ref --tune base  --action clean int

sleep 5
echo 3 > /proc/sys/vm/drop_caches

