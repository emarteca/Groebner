#!/bin/bash

while (( 1 > 0 )); do
	./pls.sh | aplay --rate=$(( ( RANDOM % 200) * 250 + 100 )) 

done
