
# p.3 fareypls paper
# return a, b such that a/b = r mod N

frecon := proc( N, r)
	local as, bs, i, q;

	as := [ N, r];
	bs := [ 0, 1];
	i := 0;

	while 2*(as[ i + 2]^2) >= N - 1 do
		i := i + 1;
		q := floor( as[ i] / as[ i + 1]);
		as := [ op( as), as[ i] - q * as[ i  + 1]];
		bs := [ op( bs), bs[ i] - q * bs[ i  + 1]];
	end do;

	if 2*(bs[ i + 2]^2) < N - 1 and gcd( as[ i + 2], bs[ i + 2]) = 1 then
		return [ as[ i + 2], bs[ i + 2]], true;
	else
		#print( "OOOOOOOOOH NO");
		return [ as[ i + 2], bs[ i + 2]], false;
	end if;

end;









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
	if abs(w[ 1]) <= N and w[ 2] > 0 and w[ 2] <= d and gcd( w[ 1], w[ 2]) = 1 and gcd( w[ 2], m) = 1 then
		return w;
	else
		print( "There is not a unique rat recon");
		return w;
	end if;


end;