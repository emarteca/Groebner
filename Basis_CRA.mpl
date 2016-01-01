
symmMod := proc( F, curPrime)
	
	local Fi, newB;

	newB := [];

	`mod` := mods;

	for Fi in F do
		newB := [ op( newB), Fi mod curPrime];
	end do;

	return newB;
	
	
end;





# Groebner method using CRA
# pass in a basis, an ordering, and a list of primes

# acNum is a hack atm (which doesn't even work huehuehuehuehue)

Basis_CRA := proc( B, ord, primes, acNums)
	local curBasis, newBasis, oldBasis, curPrime, i, isDone, informalPrimes;
	
	# one thing to check is if the built-in groebner basis does mod or mods for characteristic
	
	# incrementally run the basis for each prime, cra the results as they come in

	informalPrimes := [ op(primes)];
	
	curPrime := informalPrimes[1];
	curBasis := symmMod( Basis( B, ord, method=maplef4, characteristic=informalPrimes[1]), curPrime);

	i := 2;

	#while not isOkPrime( curBasis, acNums) do
	while not isPauerLucky( curPrime, B, ord) do
		#print( "OH NOOOOOO");
		informalPrimes := [ op( informalPrimes), nextprime( informalPrimes[ nops( informalPrimes)])];
		curBasis := symmMod( Basis( B, ord, method=maplef4, characteristic=informalPrimes[ i]), informalPrimes[ i]);
		curPrime := informalPrimes[ i];
		i := i + 1;
	end do;

	#print( curBasis);
	

	#i := 2;
	isDone := false;
	
	# TODO error check for invalid primes!!
	while not isDone do #i <= nops( informalPrimes) and not isDone do  # max iterations once per prime 
		#print( "HERE!");
		informalPrimes := [ op( informalPrimes), nextprime( informalPrimes[ nops( informalPrimes)])];

		newBasis := symmMod (Basis( B, ord, method=maplef4, characteristic=informalPrimes[i]), informalPrimes[ i]);
		#print( newBasis);

		#if not isOkPrime( newBasis, acNums) then
		if not isPauerLucky( informalPrimes[ i], B, ord) then
			print( "WAT");
			continue;
		end if;
		
		# now, combine curBasis and newBasis via cra
		#print( ord);
		oldBasis := [ op( curBasis)];
		print( oldBasis);
		curBasis, isDone := CRA_sets( curBasis, curPrime, newBasis, informalPrimes[ i], ord); # return true for isDone if LTs same
		curBasis := basisrecon( curPrime, curBasis);

		isDone := ( oldBasis = curBasis);
		#print( curBasis);
	
		curPrime := curPrime * informalPrimes[ i];
		i := i + 1;
		
	end do;

	return curBasis;
	
end;

CRA_sets := proc( curBasis, curPrime, newBasis, newPrime, ord)
	local oldLTerms, newLTerms, liftBasis, i;
	
	oldLTerms := [];
	newLTerms := [];
	
	liftBasis := [];
	#print( ord);
	
	# assume lists are of same length
	
	`mod` := mods;

	i := 1;
	while ( i <= nops( curBasis)) do
		oldLTerms := [ op( oldLTerms), LeadingTerm( curBasis[ i], ord)];
		liftBasis := [ op( liftBasis), CRA_int( [ curPrime, newPrime], [ curBasis[ i], newBasis[ i]])];
		newLTerms := [ op( newLTerms), LeadingTerm( liftBasis[ i], ord)];

		#print( "...........................................");
		#print (oldLTerms);
		#print (newLTerms);
		#print( "************");
		#print( liftBasis);
		#print( "????????????????????????????????????????????");
		
		i := i + 1;
	end do;

	#print( oldLTerms);
	
	return liftBasis, ( oldLTerms = newLTerms);
	
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
