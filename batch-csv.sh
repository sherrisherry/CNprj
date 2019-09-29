#!/bin/bash
# non-12-cell rows into batch.log
# Use UTF-8 instead of utf8; > instead of -o in Mac OS terminal
ind=download
otd=outputs
log=batch.log
head -n1 $ind/$(ls $ind | head -n1) | iconv -f GB2312 -t utf8 -o $otd/export.csv
cp $otd/export.csv $otd/import.csv
> $log
for f in $(ls $ind/e*.csv); do
echo $f >> $log;
tail -n +2 $f | iconv -f GB2312 -t utf8 | ./batch-csv.sh.py $log >> $otd/export.csv;
done
for f in $(ls $ind/i*.csv); do
echo $f >> $log;
tail -n +2 $f | iconv -f GB2312 -t utf8 | ./batch-csv.sh.py $log >> $otd/import.csv;
done
head -n100 $otd/import.csv > sample.csv
