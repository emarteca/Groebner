exNum := 1:
theMethod := 2:  #if 1 maple, 2 CRA, 3 Hensel
theAlgoType := buchberger: # could also be maplef4

with( Groebner):

read( "irecon.mpl"):
read( "intpolyrecon.mpl"):
read( "cra_int.mpl"):
#read( "pauerLucky.mpl"):
read( "Basis_CRA.mpl"):
#read( "Basis_Hensel.mpl");

read( "allTheExamples.mpl"):

read( "SoUseful.mpl"):

# so it looks like command line args aren't a thing in maple
# so, i'll just make a bash script run the maple script which 
# is secretly a bash script


primes := [ prevprime( 2^16 - 1)]:

fileName := cat( "output_ex", convert( exNum, string), "_", 
                 convert( theAlgoType, string), ".txt"):

if theMethod = 1 then  # run with maple
  tt := time():
  sol := Basis( totBs[ exNum], totOrds[ exNum], method=theAlgoType):
  tt := time() - tt:

  writeto( fileName):
  print( exNames[ exNum]);
  print( "Basis with maple");
  print( "\nTime: ");
  print( tt);
  print( "\nSolution: ");
  print( sol);
  writeto( terminal):

elif theMethod = 2 then # CRA

  tt := time():
  sol, primeTime, numImgs, modBasisTime, fareyReconTime, 
       craReconTime := Basis_CRA( totBs[ exNum], 
                                  totOrds[ exNum], primes, theAlgoType);
  print( sol);
  procTime := time():
  tt := procTime - tt:
  primeTime := tt - (procTime - primeTime):

  appendto( fileName);
  print( "Basis with CRA");
  print( "\nTime: ");
  print( tt);
  print( "\nmodBasisTime: ");
  print( modBasisTime);
  print( "\nfareyReconTime: ");
  print( fareyReconTime);
  print( "\craReconTime: ");
  print( craReconTime);
  print( "\nNum images: ");
  print( numImgs);
  print( "\nSolution");
  print( sol);
  writeto( terminal):
else 

  isLegit := false:
  numTries := 0:
  curPrime := primes[ 1];
  liftTimes := [];

  while not isLegit do
    tt := time():
    sol, isLegit, liftTimes := Basis_Hensel( totBs[ exNum], totOrds[ exNum], 
                                             nextprime( curPrime)):
    procTime := time():
    tt := procTime - tt:
    numTries := numTries + 1:
  end;

  appendto( fileName);
  print( "Basis with Hensel");
  print( "\nTime: ");
  print( tt);
  print( "Lift timings");
  i := 1:
  for l in liftTimes do
    print( "\n");
    print( i);
    print( " lift :"):
    print( l);
    i := i + 1:
  end;
  print( "\nNumber of tries: ");
  print( numTries);
  print( "\nSolution");
  print( sol);
  writeto( terminal):
fi:
