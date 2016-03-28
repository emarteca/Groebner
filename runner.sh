#!/bin/bash


exNum=`echo 1`

while (( exNum <= 25 )); do    # run for all the examples

  theMethod=1
  algoType=1 # specifies running with buchberger, maplef4, or fgb

  while (( theMethod <= 3 )); do       # run for maple, cra, and hensel

    if (( algoType == 1 )); then

      sed s/"exNum := 1"/"exNum := `echo $exNum`"/ timer.mpl | 
          sed s/"theMethod := 1"/"theMethod := `echo $theMethod`"/ | 
          sed s/"theAlgoType := buchberger"/"theAlgoType := fgb"/ | maple

      (( algoType = $algoType + 1 ))

    elif (( algoType == 2 )); then

      sed s/"exNum := 1"/"exNum := `echo $exNum`"/ timer.mpl | 
          sed s/"theMethod := 1"/"theMethod := `echo $theMethod`"/ | 
          sed s/"theAlgoType := buchberger"/"theAlgoType := maplef4"/ | maple

      (( algoType = $algoType + 1 ))

    else

      sed s/"exNum := 1"/"exNum := `echo $exNum`"/ timer.mpl | 
          sed s/"theMethod := 1"/"theMethod := `echo $theMethod`"/ | maple
      
      (( theMethod = $theMethod + 1 ))
    fi
  done
  (( exNum = $exNum + 1 ))
done


