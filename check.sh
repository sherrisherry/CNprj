#!/bin/bash
> check.txt
for f in $(ls $otd); do
echo $f >> check.txt;
grep -o -n '","' $otd/$f | cut -d : -f 1 | uniq -c | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | grep -v '^11 ' >> check.txt;
done
