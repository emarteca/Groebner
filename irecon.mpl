# euclid's alg repurposed for rational reconstruction

# m is the mod 
# n is the number

irecon := proc( m, n)
	
	local v, w, i, N, d, q, z;

	v := [ m, 0];
	w := [ n, 1];

	# now, we need N and d
	# take N = D = i where i is the largest integer satisfying 2i^2 < m

	i := floor( sqrt( m/2));
	d := i;
	N := i;

	while w[ 1] > N do
		q := floor( v[ 1] / w[ 1]);
		z := v - q*w;

		v := w;
		w := z;
	end do; 

	if w[ 2] < 0 then
		w := -w;
	end;


	# error checking
	if w[ 2] < d and gcd( w[ 1], w[ 2]) = 1 then
		return w;
	else
		print( "There is not a unique rat recon");
		return [-1, -1];
	end if;


end;