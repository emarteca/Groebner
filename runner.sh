#!/bin/bash


#sed s/'m := 1'/'exNum := 2'/ timer.mpl | maple

exNum=`echo 1`

while (( exNum <= 10 )); do
	theMethod=1
	algoType=1
	while (( theMethod <= 3 )); do
		if (( algoType < 2 )); then
			sed s/"exNum := 1"/"exNum := `echo $exNum`"/ timer.mpl | sed s/"theMethod := 1"/"theMethod := `echo $theMethod`"/ | sed s/"theAlgoType := buchberger"/"theAlgoType := maplef4"/ | ~/maple13/bin/maple
			(( algoType = $algoType + 1 ))
		else
			sed s/"exNum := 1"/"exNum := `echo $exNum`"/ timer.mpl | sed s/"theMethod := 1"/"theMethod := `echo $theMethod`"/ | ~/maple13/bin/maple
			(( theMethod = $theMethod + 1 ))
		fi
	done
	(( exNum = $exNum + 1 ))
done


