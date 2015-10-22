# maple chinese remainder algorithm for polynomial reconstruction with integer coefficients

# todo later rational reconstruction for Q

# start with u mod various primes
# you have a list of the primes, and a list of the modular images

# mis is the prime list
# modImgs is the list of modular images (here, they're polynomials)
CRA_int := proc( mis, modImgs) 
		
		local i, gammas, vs, curProds, curTerm := 1;

		# compute the gammas (these are the inverses necessary)

		gammas := [ 1];
		curProds := [ 1];

		for i from 1 to (nops( mis) - 1) do # nops( mis) == nops( modImgs)
			# gamma = (product of the mis) mod mi

			curTerm := curTerm * mis[ i];
			curProds := [ op( curProds), curTerm];

			# mods is symmetric modular img
			gammas := [ op( gammas), mods( 1/curTerm, mis[ i + 1])];
		od;

		# now we need to find the v's (which are going to be polynomials now)

		vs := [];
		curTerm := 0; # might as well reuse

		# v1 = modImgs[ 1]
		# v2 = (modImgs[ 2] - v1)*gamma[1] mods m1
		# vi = (modImgs[ i] - sumOfVs) * gammas[ i - 1]   mods m[ i] 

		for i from 1 to nops( mis) do
			vs := [ op( vs), mods((modImgs[ i] - curTerm) * gammas[ i], mis[ i])];
			curTerm := curTerm + curProds[ i]*vs[ i];
		od;

		# now have to compute u
		# u = v0 + v1m0 + v2m0m1 

		curTerm := 0; # reuse this as the value to return

		for i from 1 to nops( mis) do
			curTerm := curTerm + vs[ i] * curProds[ i];
		od; 

		return curTerm;


	
end;