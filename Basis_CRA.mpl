
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
	local curBasis, newBasis, oldBasis, curPrime, i, isDone, isGoodPrime, everBad, informalPrimes, curMultiplier, primeTime, stopTiming;
	
	# one thing to check is if the built-in groebner basis does mod or mods for characteristic
	
	# incrementally run the basis for each prime, cra the results as they come in

	informalPrimes := [ op(primes)];
	
	curPrime := informalPrimes[1];
	curBasis := symmMod( Basis( B, ord, method=buchberger, characteristic=informalPrimes[1]), curPrime);

	i := 2;

	isDone := false;
	curMultiplier := 1;
	everBad := true;
	primeTime := time();
	stopTiming := false;
	
	# TODO error check for invalid primes!!
	while not isDone do #i <= nops( informalPrimes) and not isDone do  # max iterations once per prime 
		#print( "HERE!");
		informalPrimes := [ op( informalPrimes), nextprime( (ceil( informalPrimes[ nops( informalPrimes)] * curMultiplier) + 1000000000))];

		if i = 1 then
			informalPrimes := [ informalPrimes[ nops( informalPrimes)]]; 
			curPrime := informalPrimes[ 1];
			curBasis := symmMod( Basis( B, ord, method=buchberger, characteristic=informalPrimes[ 1]), curPrime);
			i := i + 1;
			#print( "HERE");
		else

			newBasis := symmMod (Basis( B, ord, method=buchberger, characteristic=informalPrimes[i]), informalPrimes[ i]);
			
			# now, combine curBasis and newBasis via cra
			oldBasis := [ op( curBasis)];
			curBasis := CRA_sets( curBasis, curPrime, newBasis, informalPrimes[ i], ord); 
			curBasis, isGoodPrime := basisrecon( curPrime, curBasis);

			if isGoodPrime then
				isDone := ( oldBasis = curBasis);
				print( informalPrimes[ i]);
		
				curPrime := curPrime * informalPrimes[ i];
				curMultiplier := 1;

				if everBad then
					informalPrimes := [ informalPrimes[ nops( informalPrimes)]];
					curPrime := informalPrimes[ 1];

					if i > 2 then
						everBad := false;
					fi;

					stopTiming := true;

					i := 1;

				fi;

				#print( "OMG");
			else
				curBasis := [ op( oldBasis)];
				isDone := false;
				#print( "Here Lol");

				if everBad and i > 1 then
					informalPrimes := [ informalPrimes[ nops( informalPrimes)]];
					#print( "WHY");
					curPrime := informalPrimes[ 1];
					i := 0;
					curMultiplier := 1.5;

					if not stopTiming then
						primeTime := time();
					fi;
				fi;

			fi;

			i := i + 1;
			
		fi; # end if for i = 1
		
	end do;

	return curBasis, primeTime;
	
end;

CRA_sets := proc( curBasis, curPrime, newBasis, newPrime, ord)
	local liftBasis, i;
	
	liftBasis := [];
	#print( ord);
	
	# assume lists are of same length
	
	`mod` := mods;

	i := 1;
	while ( i <= nops( curBasis)) do
		liftBasis := [ op( liftBasis), CRA_int( [ curPrime, newPrime], [ curBasis[ i], newBasis[ i]])];
		
		i := i + 1;
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