# lucky primes: 
# all Pauer lucky primes are also Hilbert lucky (but not vice versa)
# Pauer lucky -- p is Pauer lucky if its coprime with all c belongs to lc( G)
#			  -- alternatively, can say p is Pauer lucky if it does not divide any 
#				 leading coefficients (according to the monomial ordering specified)

isPauerLucky := proc( p, B, ord)

	local soLuck, i, curCoeff;

	soLuck := true;

	i := 1;
	while i <= nops( B) do
		curCoeff := LeadingCoefficient( B[ i], ord);
		if curCoeff mod p = 0 then
			soLuck := false;
		fi;
	end;

	return soLuck;

end: 