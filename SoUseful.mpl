# useful maple methods that should really exist already

reverse := proc( L)
	local revL, i := 1;

	revL := [];

	while i <= nops( L) do
		revL := [ L[i], op( revL)];
		i := i + 1;
	end do;

	return revL;

end;


splitAndParse := proc( s, delim)
	local split, i, curString, delimReached;

	split := [];
	i := 1;
	curString := "";
	delimReached := false;

	while i <= length( s) do
		if s[ i] <> delim then
			delimReached := false;
			curString := cat( curString, s[ i]);
		else
			delimReached := true;
			split := [ op( split), parse( curString)];
			curString := "";
		end if;
		i := i + 1;
	end do;

	#if  delimReached := true then
	#split := [ op( split), parse( curString)];
	return split;
end;


powerProduct := proc( poly, ord)
	local powerProds, i;

	i := 1;
	powerProds := [];

	while i <= nops( poly) do
		powerProds := [ op( powerProds), LeadingTerm( op( poly)[ i], ord)[2]];
		i := i + 1;
	end do;

	return powerProds; 
end;