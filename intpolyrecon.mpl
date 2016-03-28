# rational reconstruction 
# for polynomials with integer coefficients

# m is the mod 
# p is the polynomial (with integer coeffs) which results from the mod

intpolyrecon := proc( m, p)
  
  local polst, i, curCoeff, curTerm, newPoly, isGoodPrime;

  polst := [op( p)];
  newPoly := 0;

  for i from 1 to nops( polst) do
    curTerm := coeffs( polst[ i]); # should give you a list of coeffs but 
                                   # here there's just one, since one term
    curCoeff := iratrecon( curTerm, m);
    # now need to update the coefficient in the list (add to new list)
    newPoly := newPoly + polst[ i] * (1/curTerm) * curCoeff; 

    isGoodPrime := curCoeff <> FAIL;

    if not isGoodPrime then
      return newPoly, false;
    fi;
  od;
  
  return newPoly, true;

end;


# this reconstructs a basis of polynomials, i.e. calls the intpolyrecon
# for each of the polynomials in the basis 
basisrecon := proc( m, B)
  local p, newB, curP, isGoodPrime;

  newB := [];

  for p in B do
    curP, isGoodPrime := intpolyrecon( m, p);
    newB := [ op(newB), curP * denom( curP)];

    if not isGoodPrime then
      return newB, false;
    fi;
  od;

  return newB, true;

end;