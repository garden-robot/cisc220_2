#!/bin/bash

ps axo comm,pid,ppid,start,user > processesTreeRaw.txt

commData=$(awk '{print $1}' processesTreeRaw.txt)
pidData=$(awk '{print $2}' processesTreeRaw.txt)
ppidData=$(awk '{print $3}' processesTreeRaw.txt)
startData=$(awk '{print $4}' processesTreeRaw.txt)
userData=$(awk '{print $5}' processesTreeRaw.txt)

rm processesTreeRaw.txt

for line in $pidData ; do
        sed '${line}q;d' $commData
        j=line
        break
        for j in $ppidData ; do
                if ($j$ppidData==$line$pidData) ; then
                        echo "Child process of PID $line$pidData: $j$commData PID: $j$pidData PPID: $j$ppidData STARTED: $j$startData by: $j$userData"
                fi
        done
        line=j;
done