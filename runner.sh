#!/bin/bash


#sed s/'m := 1'/'exNum := 2'/ timer.mpl | maple

exNum=`echo 1`

while (( exNum <= 10 )); do
	theMethod=1
	while (( theMethod <= 3 )); do
		sed s/"exNum := 1"/"exNum := `echo $exNum`"/ timer.mpl | sed s/"theMethod := 1"/"theMethod := `echo $theMethod`"/ ~/maple13/bin/maple
		(( theMethod = $theMethod + 1 ))
	done
	(( exNum = $exNum + 1 ))
done


