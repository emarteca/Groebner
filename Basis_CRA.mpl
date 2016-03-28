# method to compute the symmetric modulus of a basis mod a particular prime
symmMod := proc( F, curPrime)
  
  local Fi, newB;

  newB := [];

  #`mod` := mods;

  for Fi in F do
    newB := [ op( newB), mods( Fi, curPrime)];
  end do;

  return newB;
  
  
end;





# Groebner method using CRA
# pass in a basis, an ordering, and a list of primes

Basis_CRA := proc( B, ord, primes, theAlgoType)
  local curBasis, newBasis, oldBasis, curPrime, i, isDone, isGoodPrime, 
  informalPrimes, primeTime, theMonoms, newPrime, tempBasis, 
  lastTempBasis, modBasisTime, craReconTime, fareyReconTime, tempTime;
  
  # incrementally run the basis for each prime, cra the results as they come in

  informalPrimes := [ op(primes)];
  
  curPrime := informalPrimes[1];
  modBasisTime := time();
  curBasis := symmMod( Basis( B, ord, method=theAlgoType, 
                       characteristic=informalPrimes[1]), curPrime);
  modBasisTime := time() - modBasisTime;
  theMonoms := LeadingMonomial( curBasis, ord);

  curPrime := informalPrimes[1];

  lastTempBasis := [];
  fareyReconTime := time();
  tempBasis, isGoodPrime := basisrecon( curPrime, curBasis);
  fareyReconTime := time() - fareyReconTime;

  craReconTime := 0;

  if not isGoodPrime then
    tempBasis := [];
  fi;

  i := 1;

  isDone := false;
  primeTime := time();

  while not isDone do 
    
    newPrime := prevprime( informalPrimes[ nops( informalPrimes)]);
  
    tempTime := time();
    newBasis := symmMod (Basis( B, ord, method=theAlgoType, 
                                characteristic=newPrime), newPrime);
    modBasisTime := modBasisTime + (time() - tempTime);
    theMonoms := LeadingMonomial( newBasis, ord);


    # assuming the first prime was a good prime, this checks that the new
    # prime is actually a good prime
    if theMonoms = (LeadingMonomial( curBasis, ord) mod newPrime) then

      # now, combine curBasis and newBasis via cra
      tempTime := time();
      curBasis := CRA_sets( curBasis, curPrime, newBasis, newPrime, ord); 
      craReconTime := craReconTime + (time() - tempTime);
      
      lastTempBasis := tempBasis;
      tempTime := time();
      tempBasis, isGoodPrime := basisrecon( curPrime, curBasis);
      
      fareyReconTime := fareyReconTime + (time() - tempTime);

      if not isGoodPrime then
        tempBasis := [];
      elif lastTempBasis = tempBasis and nops( lastTempBasis) <> 0 then
        isDone := true;
      fi;


      informalPrimes := [ op( informalPrimes), 
                          prevprime( informalPrimes[ nops( informalPrimes)])]:

      i := i + 1;
      curPrime := curPrime * newPrime;

    fi;
    
    
  end do;

  return tempBasis, primeTime, i, modBasisTime, fareyReconTime, craReconTime;
  
end;


# method to perform a lift of a 
CRA_sets := proc( curBasis, curPrime, newBasis, newPrime, ord)
  local liftBasis, i, k, newBasisCoeffs, oldBasisCoeffs, numCoeffs, oldPrime, 
  newParsedCoeffs, powerProducts, newPoly, cLiftBasis;
  
  liftBasis := [];
  cLiftBasis := [];
  
  # assume lists are of same length
  
  i := 1;
  while ( i <= nops( curBasis)) do
    liftBasis := [ op( liftBasis), CRA_int( [ curPrime, newPrime], 
                                            [ curBasis[ i], newBasis[ i]])];
    
    i := i + 1;
  end do;

  return liftBasis;
  
end;



# method to check that the computed basis is actually a basis for this ideal
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
