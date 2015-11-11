# Groebner method using CRA
# pass in a basis, an ordering, and a list of primes

Basis_CRA := proc( B, ord, primes)
	local curBasis, newBasis, curPrime, i, done;
	
	# one thing to check is if the built-in groebner basis does mod or mods for characteristic
	
	# incrementally run the basis for each prime, cra the results as they come in
	
	curBasis := Basis( B, ord, method=fgb, characteristic=primes[1]);
	curPrime := primes[1];
	
	i := 2;
	done := false;
	
	# TODO error check for invalid primes!!
	while ( i <= nops( primes) and !done) do  # max iterations once per prime 
		curPrime = curPrime * primes[ i];
		
		newBasis := Basis( B, ord, method=fgb, characteristic=primes[i]);
		
		# now, combine curBasis and newBasis via cra
		[curBasis, done] := CRA_sets( curBasis, curPrime, newBasis, primes[ i], ord); # return true for done if LTs same
	
		i := i + 1;
	end do;
	
end;

CRA_sets := proc( curBasis, curPrime, newBasis, newPrime, ord)
	local oldLTerms, newLTerms, liftBasis, i;
	
	oldLTerms := [];
	newLTerms := [];
	
	liftBasis := [];
	
	# assume lists are of same length
	
	i := 1;
	while ( i <= nops( curBasis)) do
		oldLTerms := [ op( oldLTerms), LeadingTerm( curBasis[ i], ord)];
		liftBasis := [ op( liftBasis), cra_int( [ curPrime, newPrime], [ curBasis[ i], newBasis[ i]);
		newLTerms := [ op( newLTerms), LeadingTerm( liftBasis[ i], ord)]
		
		i := i + 1;
	end do;
	
	return [ liftBasis, ( oldLTerms = newLTerms)];
	
end;