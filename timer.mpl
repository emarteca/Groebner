exNum := 1:
theMethod := 2:  #if 1 maple, 2 CRA, 3 Hensel
theAlgoType := buchberger: # could also be maplef4

with( Groebner):

read( "irecon.mpl"):
read( "intpolyrecon.mpl"):
read( "cra_int.mpl"):
read( "pauerLucky.mpl"):
read( "Basis_CRA.mpl"):
read( "Basis_Hensel.mpl");

read( "allTheExamples.mpl"):

read( "SoUseful.mpl"):

# cra_int( int* oldPrime, int newPrime, int* oldCoeffs, int* newCoeffs, int numCoeffs)

CRA_pls := define_external( 'cra_int', 'oldPrime'::ARRAY(integer[4]), 'newPrime'::(integer[8]), 'oldCoeffs'::(ARRAY(1..i, 1..j, integer[4])), 'newCoeffs'::ARRAY(integer[4]), 'numCoeffs'::(integer[4]), RETURN::(string), LIB="plstolib.so.1.0.1"):


# so it looks like command line args aren't a thing in maple?
# so, i'll just make a bash script run the maple script which is secretly a bash script


# right now there are 4 examples to parse through
#exNum := 1:

primes := [ prevprime( 2^16 - 1)]:
#for i from 1 to 20 do
#	primes := [ op( primes), nextprime( primes[ i] + 10000)];			# sequence of 10 10-digit primes sequentially 
#od:

# recall we have exNames from examples.mpl which is the names of each example

#for exNum from 1 to nops( totBs) do
	# run example with Basis
	# run example with Basis_CRA
	# print times to a file

	#exNum := 4;

	fileName := cat( "output_ex", convert( exNum, string), "_", convert( theAlgoType, string), ".txt"):

	if theMethod = 1 then
		tt := time():
		sol := Basis( totBs[ exNum], totOrds[ exNum], method=theAlgoType):
		tt := time() - tt:
		
		acMonoms := LeadingMonomial( sol, totOrds[ exNum]):

		writeto( fileName):
		print( exNames[ exNum]);
		print( "Basis with maplef4");
		print( "\nTime: ");
		print( tt);
		print( "\nSolution: ");
		print( sol);
		writeto( terminal):
	elif theMethod = 2 then

		#sol := Basis( totBs[ exNum], totOrds[ exNum]):
		#print( sol);
		#acMonoms := LeadingMonomial( sol, totOrds[ exNum]):

		tt := time():
		sol, primeTime, numImgs, modBasisTime, fareyReconTime, craReconTime := Basis_CRA( totBs[ exNum], totOrds[ exNum], primes, theAlgoType);
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
			sol, isLegit, liftTimes := Basis_Hensel( totBs[ exNum], totOrds[ exNum], nextprime( curPrime)):
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

	#exNum := 12;


#od: