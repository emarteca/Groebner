# buchberger's algorithm using the CRA to lift
# we need a basis passed in

Spoly := proc( p1, p2)
	# takes in 2 polynomials and returns the spolynomial with respect to x
	# the formula is lcm(LT(p1), LT(p2)) multiplied by p1/LT(p1) - p2/LT(p2)
	# this cancels out the leading terms of p1 and p2

	local lp1, lp2;
	
	lp1 := op( p1)[ 1];
	lp2 := op( p2)[ 1];
	
	return expand( lcm( lp1, lp2) * ( p1/lp1 - p2/lp2));
end;

complementBy := proc( p, S)
	# takes in polynomial p and set S
	# divides p by every element in the set and returns the remainder
	
	local f, totRem := p;
	
	for f in S do
		totRem := rem( totRem, f, x); 
	end do;
	
	return totRem;
	
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

# F is the generating set for the ideal
BB_CRA := proc( F, ord)    
	local G, Gp, p, q, S; # the groebner basis
	G := F;
	
	do
		Gp := G;
		
		for p in Gp do
			for q in Gp do
				if p <> q then
					#S := complementBy( Spoly( p, q), Gp);
					S := Reduce( SPolynomial( p, q, ord), G, ord);
					if S <> 0 then
						G := [ op(G), S];
						print(S);
					fi;
				fi;
			end do;
		end do;
		#print(G);
		#print(Gp);
		
		if nops( Gp) = nops( G) then	# then nothing has changed (since the only other option is for 
			break;						# a poly to have been added to G) and the algorithm has terminated
			print( "WAT");
		fi;
	
	end do;

	return G;
	
	
end;