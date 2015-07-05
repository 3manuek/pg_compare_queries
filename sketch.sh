#!/bin/bash

#
# This is a bassic algorithm, the idea is to have a better one.
# 
# It compares the time on both queries.
#
# TODO:
# - Dynamic values using random normals with sd and means (heuristic).
# - Do queries using pg_stats most common values (by cost). 
# - No limit in order to queries.
# - Enable paralelism.
# - Compare explain, explain analyze and compare costs and time.

cat /dev/null > q1.time
cat /dev/null > q2.time

for i in $(seq 1 50) 
do
 /usr/bin/time --format='%e' -a --output='q1.time' -- psql -h172.24.16.11 -Uecb_admin playcricket_live -f q1.sql > /dev/null & 
 /usr/bin/time --format='%e' -a --output='q2.time' -- psql -h172.24.16.11 -Uecb_admin playcricket_live -f q2.sql > /dev/null & 
done

sleep 5 

awk '{sum+=$1} END {print sum}' q1.time
awk '{sum+=$1} END {print sum}' q2.time

exit 0

