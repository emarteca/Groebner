
HC := proc(p,X) 
	LeadingCoefficient(p,X) 
end:

HM := proc(p,X) 
	LeadingMonomial(p,X) 
end:

normalize := proc(p,X) 
	if p<>0 then 
		p/HC(p,X) 
	else 
		0 
	fi 
end:


lmult := proc(Z,F)
    local m,n,G,zi,i,j;
    G := [];
    m := nops(Z);  n := nops(F);
    for i from 1 to m do
        zi := Z[i];
        G := [ op(G), expand(sum(zi[j]*F[j],j=1..n)) ];
    od;
    RETURN(G)
end:


makeM := proc(Gprime,Gp,X,thePrime)
    local Gdouble,M,i,gtemp,mtemp;
    Gdouble := [];  M := [];
    for i from 1 to nops(Gprime) do
        gtemp := NormalForm(Gprime[i],Gp,X,'mtemp',characteristic=thePrime);
        Gdouble := [ op(Gdouble), gtemp ];
        M := [ op(M), mtemp ];
    od;
    RETURN( Gdouble,M )
end:



normalizeZG := proc(Zin,Gin,X,p)
    local i,hcinv,Z,G;
    Z := Zin;  G := Gin;
    for i to nops(G) do
        hcinv := 1/LeadingCoefficient(G[i],X) mod p;
        G := subsop(i=hcinv*G[i] mod p, G);
        Z := subsop(i=hcinv*Z[i] mod p, Z);
    od;
    RETURN( Z,G )
end:

plift := proc(Zin,F,Gin,p,Gp,X,i)
    local Gprime,Gprimeprime,M,Zprimeprime,G,Z;
    Gprime := ( lmult(Zin,F) - Gin )/p^(i-1);
    Gprimeprime,M := makeM(Gprime,Gp,X,p);
    Zprimeprime := -lmult(M,Zin) mod p;
    G := Gin + p^(i-1)*Gprimeprime;
    Z := Zin + p^(i-1)*Zprimeprime;
    RETURN( G,Z )
end:


verifyBasis := proc( B, ord, curG, thePrime, i)
	local G, NG, conc;

	G := Basis( B, ord): 
	NG := map( normalize, G, ord):


	# return if bad prime                
	conc := (NG = iratrecon( curG, thePrime^(i-1))):




end:




# Basis_Hensel( totBs[ exNum], totOrds[ exNum], primes[ 1]):

Basis_Hensel := proc( B, ord, thePrime)
	local Gp, Z1, Znorm, Gpnorm, curG, curZ, i, oldRec, curRec;

	
	Gp, Z1 := Basis( B, ord, characteristic=thePrime, method=buchberger, output=extended):

	Gp := Gp * lcm( op( denom( Gp))); # normalize won't crash with fractions (i.e. convert to ints)


	Znorm,Gpnorm := normalizeZG(Z1,Gp,ord,thePrime):

	curG := Gpnorm:
	curZ := Znorm:
	i := 2:

	oldRec := iratrecon(curG, thePrime^2):
	curRec := []:

	while oldRec <> curRec or curRec = FAIL do
		curG, curZ := plift( curZ, B, curG, thePrime, Gpnorm, ord, i):
		oldRec := curRec:
		curRec := iratrecon( curG, thePrime^i):
		if curRec = FAIL then
			oldRec := FAIL;
		fi:
		print( i);
		i := i + 1:
	end:

	return iratrecon( curG, thePrime^(i-1)), verifyBasis( B, ord, curG, thePrime, i);

end:

                          



                   
