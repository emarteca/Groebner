with( Groebner):

read( "irecon.mpl"):
read( "intpolyrecon.mpl"):
read( "cra_int.mpl"):
read( "pauerLucky.mpl"):
read( "Basis_CRA.mpl"):

read( "suchExamples.mpl"):

# so it looks like command line args aren't a thing in maple?
# so, i'll just make a bash script run the maple script which is secretly a bash script


# right now there are 4 examples to parse through
exNum := 1:

primes := [ nextprime( 88294967291)]:
#for i from 1 to 20 do
#	primes := [ op( primes), nextprime( primes[ i] + 10000)];			# sequence of 10 10-digit primes sequentially 
#od:

# recall we have exNames from examples.mpl which is the names of each example

for exNum from 1 to nops( totBs) do
	# run example with Basis
	# run example with Basis_CRA
	# print times to a file

	#exNum := 4;

	tt := time():
	sol := Basis( totBs[ exNum], totOrds[ exNum], method=maplef4):
	tt := time() - tt:
	
	acNums := []:
	for i from 1 to nops( sol) do
		acNums := [ op( acNums), nops( sol[ i])]:
	od:
	#print( acNums);

	fileName := cat( "output_ex", convert( exNum, string), ".txt"):

	writeto( fileName):
	print( exNames[ exNum]);
	print( "Basis with maplef4");
	print( "\nTime: ");
	print( tt);
	print( "\nSolution: ");
	print( sol);
	writeto( terminal):

	tt := time():
	sol, primeTime := Basis_CRA( totBs[ exNum], totOrds[ exNum], primes, acNums):
	procTime := time():
	tt := procTime - tt:
	primeTime := tt - (procTime - primeTime):

	appendto( fileName);
	print( "Basis with CRA");
	print( "\nTime: ");
	print( tt);
	print( "\nPrime Time: ");
	print( primeTime);
	print( "\nSolution");
	print( sol);
	writeto( terminal):

	#exNum := 12;


od: