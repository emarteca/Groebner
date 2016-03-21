#!/bin/bash

pls=$(( ( RANDOM % 10) + 5 ))
ind=0
while (( $ind < pls )); do
	ls -l
	(( ind = $ind + 1 ))
done
