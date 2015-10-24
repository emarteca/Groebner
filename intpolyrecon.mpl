# euclid's alg repurposed for rational reconstruction
# for polynomials with integer coefficients

# m is the mod 
# p is the polynomial (with integer coeffs) which results from the mod

intpolyrecon := proc( m, p)
	
	local polst, i, curCoeff, curTerm, newPoly;

	polst := [op( p)];
	newPoly := 0;

	for i from 1 to nops( polst) do
		curTerm := coeffs( polst[ i]); # should give you a list of coeffs but here there's just one, since one term
		curCoeff := irecon( m, curTerm);
		# now need to update the coefficient in the list (add to new list)
		newPoly := newPoly + polst[ i] * (1/curTerm) * (curCoeff[ 1]/curCoeff[ 2]);;
	od;
	
	return newPoly;
	


end;