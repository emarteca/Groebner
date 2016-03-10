symmMod := proc( F, curPrime)
	
	local Fi, newB;

	newB := [];

	#`mod` := mods;

	for Fi in F do
		newB := [ op( newB), mods( Fi, curPrime)];
	end do;

	return newB;
	
	
end;





# Groebner method using CRA
# pass in a basis, an ordering, and a list of primes

# acMonom is a hack until Hilbert lucky is coded in (hopefully soon!!! :P )

Basis_CRA := proc( B, ord, primes, theAlgoType)
	local curBasis, newBasis, oldBasis, curPrime, i, isDone, isGoodPrime, informalPrimes, primeTime, theMonoms, newPrime, tempBasis, lastTempBasis, modBasisTime, craReconTime, fareyReconTime, tempTime;
	
	# one thing to check is if the built-in groebner basis does mod or mods for characteristic
	
	# incrementally run the basis for each prime, cra the results as they come in




	# Did you profile the CRA code to determine the relative proportions of modular basis computation, CRA reconstruction, Farey reconstruction? 


	informalPrimes := [ op(primes)];
	
	curPrime := informalPrimes[1];
	modBasisTime := time();
	curBasis := symmMod( Basis( B, ord, method=theAlgoType, characteristic=informalPrimes[1]), curPrime);
	modBasisTime := time() - modBasisTime;
	theMonoms := LeadingMonomial( curBasis, ord);

	#print( theMonoms);
	#print( acMonoms);

	#while theMonoms <> (acMonoms mod curPrime) do
	#	curPrime := prevprime( curPrime):
	#	informalPrimes := [ curPrime]:
	#	curBasis := symmMod( Basis( B, ord, method=theAlgoType, characteristic=informalPrimes[1]), curPrime);
	#	theMonoms := LeadingMonomial( curBasis, ord);
	#end do:

	curPrime := informalPrimes[1];

	lastTempBasis := [];
	fareyReconTime := time();
	tempBasis, isGoodPrime := basisrecon( curPrime, curBasis);
	fareyReconTime := time() - fareyReconTime;

	if not isGoodPrime then
		tempBasis := [];
	fi;

	i := 1;

	isDone := false;
	primeTime := time();

	
	# TODO error check for invalid primes!!

	while not isDone do 
		
		newPrime := prevprime( informalPrimes[ nops( informalPrimes)]);
	
		tempTime := time();
		newBasis := symmMod (Basis( B, ord, method=theAlgoType, characteristic=newPrime), newPrime);
		modBasisTime := modBasisTime + (time() - tempTime);
		theMonoms := LeadingMonomial( newBasis, ord);


		#if theMonoms = (acMonoms mod newPrime) then

			# now, combine curBasis and newBasis via cra
			#print( "OMFG");
			craReconTime := time();
			curBasis := CRA_sets( curBasis, curPrime, newBasis, newPrime, ord); 
			craReconTime := time() - craReconTime;
			#print( "WHAT");
			#break;

			lastTempBasis := tempBasis;
			tempTime := time();
			tempBasis, isGoodPrime := basisrecon( curPrime, curBasis);
			fareyReconTime := fareyReconTime + (time() - tempTime);

			if not isGoodPrime then
				tempBasis := [];
			elif lastTempBasis = tempBasis and nops( lastTempBasis) <> 0 then
				isDone := true;
			fi;


			informalPrimes := [ op( informalPrimes), prevprime( informalPrimes[ nops( informalPrimes)])]:

			i := i + 1;
			curPrime := curPrime * newPrime;

		#fi;
		
		
	end do;

	return tempBasis, primeTime, i, modBasisTime, fareyReconTime, craReconTime;
	
end;

CRA_sets := proc( curBasis, curPrime, newBasis, newPrime, ord)
	local liftBasis, i, k, newBasisCoeffs, oldBasisCoeffs, numCoeffs, oldPrime, newParsedCoeffs, powerProducts, newPoly, cLiftBasis;
	
	liftBasis := [];
	cLiftBasis := [];
	#print( ord);
	
	# assume lists are of same length
	
	#`mod` := mods;

	i := 1;
	while ( i <= nops( curBasis)) do
		liftBasis := [ op( liftBasis), CRA_int( [ curPrime, newPrime], [ curBasis[ i], newBasis[ i]])];

(*

		# int oldPrime[], int newPrime, int** oldCoeffs, int newCoeffs[], int numCoeffs, int **returnVals
		
		newBasisCoeffs := Vector( LeadingCoefficient( [ op( newBasis[ i])], ord) mod newPrime, datatype=integer[4]);

		oldBasisCoeffs := LeadingCoefficient( [ op( curBasis[ i])], ord) mod curPrime;

		powerProducts := powerProduct( curBasis[ i], ord);   # from SoUseful.mpl

		# convert to list of digits
		for k from 1 to nops( oldBasisCoeffs) do
			oldBasisCoeffs[ k] := [op( convert( oldBasisCoeffs[ k], base, 10)), -1];
			if k <> 1 then
				oldBasisCoeffs[ k] := [ -1, op( oldBasisCoeffs[ k])];
			end if;
		end do;
		

		oldBasisCoeffs := Matrix( oldBasisCoeffs, datatype=integer[4], order=C_order);
		
		oldPrime := Vector([ op( convert( curPrime, base, 10)), -1], datatype=integer[4]);
		

		numCoeffs := nops( powerProducts);


		# now, call the C function
		# define_external( 'cra_int', 'oldPrime'::(ARRAY(datatype=INTEGER)), 'newPrime'::(INTEGER[8]), 'oldCoeffs'::(ARRAY(1..i, 1..j, INTEGER[4])), 
		#                  'newCoeffs'::(ARRAY(datatype=INTEGER)), 'numCoeffs'::INTEGER[8], 'returnVals'::REF(ARRAY(1..i, 1..j, INTEGER[4])))

		newParsedCoeffs := CRA_pls( oldPrime, newPrime, oldBasisCoeffs, newBasisCoeffs, numCoeffs);
		
		newParsedCoeffs := splitAndParse( newParsedCoeffs, ";");
		

		# go through and make new poly
		# add to lift basis

		newPoly := 0;
		for k from 1 to nops( newParsedCoeffs) do
			newPoly := newPoly + newParsedCoeffs[ k]*powerProducts[ k];
		end do;

		cLiftBasis := [ op( cLiftBasis), newPoly];
		
		print( cat( "PLS", liftBasis));
		print( cLiftBasis);


*)
		
		i := i + 1;
		#break;
	end do;

	return liftBasis;
	
end;



isBasis := proc( F, ord)

	local p, q, S;

	for p in F do
		for q in F do
			if p <> q then
				S := Reduce( SPolynomial( p, q, ord), F, ord);
				if S <> 0 then
					return false;
				fi;
			fi;
		end do;
	end do;

	return true;

end;


isOkPrime := proc( curBasis, acNums)
	
	local i;

	for i from 1 to nops( curBasis) do
		if nops( curBasis[ i]) < acNums[ i] then
			return false;
		end if;
	od;

	return true;

end;