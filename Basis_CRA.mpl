# Groebner method using CRA
# pass in a basis, an ordering, and a list of primes

Basis_CRA := proc( B, ord, primes)
	local curBasis, newBasis, curPrime, i, isDone;
	
	# one thing to check is if the built-in groebner basis does mod or mods for characteristic
	
	# incrementally run the basis for each prime, cra the results as they come in
	
	curBasis := Basis( B, ord, method=fgb, characteristic=primes[1]);
	curPrime := primes[1];
	
	i := 2;
	isDone := false;
	
	# TODO error check for invalid primes!!
	while ( i <= nops( primes) and not isDone) do  # max iterations once per prime 
		
		newBasis := Basis( B, ord, method=fgb, characteristic=primes[i]);
		
		# now, combine curBasis and newBasis via cra
		#print( ord);
		curBasis, isDone := CRA_sets( curBasis, curPrime, newBasis, primes[ i], ord); # return true for isDone if LTs same
		#curBasis := basisrecon( curPrime, curBasis);
		#print( curBasis);
	
		curPrime := curPrime * primes[ i];
		i := i + 1;
		
	end do;

	return curBasis;
	
end;

CRA_sets := proc( curBasis, curPrime, newBasis, newPrime, ord)
	local oldLTerms, newLTerms, liftBasis, i;
	
	oldLTerms := [];
	newLTerms := [];
	
	liftBasis := [];
	print( ord);
	
	# assume lists are of same length
	
	i := 1;
	while ( i <= nops( curBasis)) do
		oldLTerms := [ op( oldLTerms), LeadingTerm( curBasis[ i], ord)];
		liftBasis := [ op( liftBasis), CRA_int( [ curPrime, newPrime], [ curBasis[ i], newBasis[ i]])];
		newLTerms := [ op( newLTerms), LeadingTerm( liftBasis[ i], ord)];
		
		i := i + 1;
	end do;
	
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