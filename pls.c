#include <gmp.h>
#include <stdlib.h>
#include <stdio.h>
#include <malloc.h>



/*

derp2 := define_external( 'derp2', 'x'\                                      
> ::ARRAY(1..i, 1..j, integer[4]), 'num'\                                      
> ::(integer[4]), RETURN::(integer[4]), LIB="plstolib.so.1.0.1");


gcc -std=c99 -fPIC -g -c -Wall pls.c -lgmp

gcc -shared -Wl,-soname,plstolib.so.1 -o plstolib.so.1.0.1 pls.o -lc -lgmp





*/

void symMod( mpz_t value, const mpz_t modBy);

int derpyMethod( int x) {
	int y = x + 5;
	return y;
}

void convertIntToMpz_md( int* theInt, mpz_t addTo, int offset) {
	// from maple, ints are passed in in order of base 10 conversion

	int i = 0;
	int cur10 = 1;
	mpz_t temp;
	mpz_init( temp);
	while( theInt[ i] != -1) {
		mpz_set_ui( temp, theInt[ i + offset]);
		mpz_mul_ui( temp, temp, cur10);

		mpz_add( addTo, addTo, temp);

		cur10 *= 10;
		++ i;
	}

	mpz_clear( temp);
}

int derp2( int* x, int num) {
	int i = 0;
	int sum = 0;
	while( i < num*2) {
		sum += x[ i];
		//printf( "\nomg%d", num);
		++ i;
	}

	int offset = num;

	mpz_t check;
	mpz_init( check);
	convertIntToMpz_md( x, check, offset);



	// result = (int**)malloc( 4*sizeof(int*));
	// *(*result[ 0]) = 1;
	// *(*result[ 1]) = 2;
	// *(*result[ 2]) = 3;
	// *(*result[ 3]) = 4;

	return sum;
}

void convertIntToMpz( int* theInt, mpz_t addTo) {
	// from maple, ints are passed in in order of base 10 conversion

	int i = 0;
	int cur10 = 1;
	mpz_t temp;
	mpz_init( temp);
	while( theInt[ i] != -1) {
		mpz_set_ui( temp, theInt[ i]);
		mpz_mul_ui( temp, temp, cur10);

		mpz_add( addTo, addTo, temp);

		cur10 *= 10;
		++ i;
	}

	mpz_clear( temp);


	// that was so inefficient
	// i think, instead, converting to a string and then using set_str might be faster?
}



void compute_cra_int( mpz_t mis[], mpz_t modImgsNew[], mpz_t modImgsOld[], int coeffIndex) {

	int misSize = 2;
	mpz_t modImgs[ misSize];

	int i;
	for( i = 0; i < misSize; ++ i) {
		mpz_init( modImgs[ i]);
	}

	mpz_set( modImgs[ 0], modImgsNew[ coeffIndex]);
	mpz_set( modImgs[ 1], modImgsOld[ coeffIndex]);


	mpz_t gammas[ misSize];
	mpz_t curProds[ misSize];

	mpz_init( gammas[ 0]);
	mpz_init( curProds[ 0]);
	mpz_set_ui( gammas[ 0], 1);
	mpz_set_ui( curProds[ 0], 1);

	mpz_t curTerm;
	mpz_init( curTerm);

	mpz_set_ui( curTerm, 1);

	
	for( i = 0; i < misSize - 1; ++ i) {
		// gamma = (product of the mis) mod mi

		mpz_t temp;
		mpz_init( temp);


		mpz_mul( curTerm, curTerm, mis[ i]);

		mpz_init( curProds[ i + 1]);
    	mpz_set( curProds[ i + 1], curTerm);

    	mpz_init( gammas[ i + 1]);

    	mpz_invert( temp, curTerm, mis[ i + 1]);
    	symMod( temp, mis[ i + 1]);

    	mpz_set( gammas[ i + 1], temp);
    	mpz_clear( temp);

	}

	// now we need to find the v's (which are going to be polynomials now)

	mpz_t vs[ misSize];
	//mpz_clear( curTerm);
	mpz_set_ui( curTerm, 0); // might as well reuse


	// v1 = modImgs[ 1]
	// v2 = (modImgs[ 2] - v1)*gamma[1] mods m1
	// vi = (modImgs[ i] - sumOfVs) * gammas[ i - 1]   mods m[ i] 

	for( i = 0; i < misSize; ++ i) {

		mpz_t temp;
		mpz_init( temp);

		mpz_init( vs[ i]);

		mpz_sub( temp, modImgs[ i], curTerm);
		mpz_mul( temp, temp, gammas[ i]);
		symMod( temp, mis[ i]);

		mpz_set( vs[ i], temp);
		//mpz_clear( temp);

		mpz_mul( temp, curProds[ i], vs[ i]);
		mpz_add( curTerm, curTerm, temp);

		mpz_clear( temp);
	}

	// now have to compute u
	// u = v0 + v1m0 + v2m0m1 

	//mpz_clear( curTerm);
	mpz_set_ui( curTerm, 0); // reuse this as the value to return

	for( i = 0; i < misSize; ++ i) {
		//gmp_printf("N = %Zd\n", curTerm);
		mpz_t temp;
		mpz_init( temp);

		mpz_mul( temp, vs[ i], curProds[ i]);
		mpz_add( curTerm, curTerm, temp);

		mpz_clear( temp);
	}

	mpz_set( modImgsOld[ coeffIndex], curTerm);

	//gmp_printf("N = %Zd\n", curTerm);

	mpz_clear( curTerm);
	for( i = 0; i < misSize; i ++) {
		mpz_clear( vs[ i]);
		mpz_clear( curProds[ i]);
		mpz_clear( gammas[ i]);
		mpz_clear( modImgs[ i]);
	}

}


int countDigs( char *toCount) {
	int i = 0;
	while( toCount[ i] != '\0') {
		++ i;
	}
	return i;
}


// only called with 2 args for misInts and modImgInts
// modImgInts is a list of coeffs though

// misInts is a 2D array (2 elts, each of x digits)
// modImgInts is a 3D array (2 elts which each are lists)

// but for now, we're just doing per coefficient



/*

	Call the CRA with a list of coefficients
	These should be in unsigned mod, since the values are taken in as unsigned
	Do the CRA on each coefficient in the list (look at threading maybe to save time)
	Have list of coefficients
	Return this list, maybe as strings or as arrays of arrays of ints more likely
	Array of coeffs, each coeff is an array of its own digits
	Then, in maple, convert back from this 
	Maybe there's a reverse base 10 conversion?

*/


void cra_int( int oldPrime[], int newPrime, int** oldCoeffs, int newCoeffs[], int numCoeffs, int **returnVals) {

	//void cra_int( mpz_ptr mis, int misSize, mpz_ptr modImgs, int modImgsSize) {
	
	int misSize = 2;
	//int modImgsSize = 6;

	mpz_t mis[ misSize];
	mpz_t modImgsNew[ numCoeffs];
	mpz_t modImgsOld[ numCoeffs];

	int j;
	for( j = 0; j < misSize; ++ j) {
		mpz_init( mis[ j]);
		//mpz_init( modImgs[ j]);

		//mpz_set_ui( mis[ j], misInts[ j]);
		//mpz_set_ui( modImgs[ j], modImgsInts[ j]);
	}

	mpz_set_ui( mis[ 0], newPrime);
	convertIntToMpz( oldPrime, mis[ 1]);

	for( j = 0; j < numCoeffs; ++ j) {
		mpz_init( modImgsOld[ j]);
		mpz_init( modImgsNew[ j]);
		convertIntToMpz( oldCoeffs[ j], modImgsOld[ j]);
		mpz_set_ui( modImgsNew[ j], newCoeffs[ j]);

		// now, do the CRA for each pair of coeffs
		// use modImgsOld at the particular coeff to solve

		compute_cra_int( mis, modImgsNew, modImgsOld, j);
	}


	// return set
	// how to return set...
	// first, get array of strings for each value

	//int *returnVals[ numCoeffs];

	returnVals = (int**) malloc( numCoeffs * sizeof(int*));

	for( j = 0; j < numCoeffs; ++ j) {

		char *tempString = NULL;

		mpz_get_str( tempString, 10, modImgsOld[ j]);      // 10 is base 10

		returnVals[ j] = (int*)malloc(countDigs(tempString) * sizeof(int));

		int i = 0;
		while( tempString[ i] != '\0') {
			returnVals[ j][ i] = (int) (tempString[ i] - '0');
			++ i;
		}

	}

	// clear mpz mem
	for( j = 0; j < numCoeffs; ++ j) {
		mpz_clear( modImgsNew[ j]);
		mpz_clear( modImgsOld[ j]);
	}

	mpz_clear( mis[ 0]);
	mpz_clear( mis[ 1]);

	//return returnVals;



	// r_1 = 1246736738 (% 2147483743)
	// r_2 = 748761 (% 2147483713)
	// r_3 = 1829651881 (% 2147483693)
	// r_4 = 2008266397 (% 2147483659)
	// r_5 = 748030137 (% 2147483647)
	// r_6 = 1460049539 (% 2147483629)

	// mpz_set_ui( mis[ 0], 2147483743);
	// mpz_set_ui( mis[ 1], 2147483713);
	// mpz_set_ui( mis[ 2], 2147483693);
	// mpz_set_ui( mis[ 3], 2147483659);
	// mpz_set_ui( mis[ 4], 2147483647);
	// mpz_set_ui( mis[ 5], 2147483629);

	// mpz_set_ui( modImgs[ 0], 1246736738);
	// mpz_set_ui( modImgs[ 1], 748761);
	// mpz_set_ui( modImgs[ 2], 1829651881);
	// mpz_set_ui( modImgs[ 3], 2008266397);
	// mpz_set_ui( modImgs[ 4], 748030137);
	// mpz_set_ui( modImgs[ 5], 1460049539);


	// this should already be in sym mod

	// for( j = 0; j < misSize; ++ j) {
	// 	symMod( modImgs[ j], mis[ j]);
	// }

}

void symMod( mpz_t value, const mpz_t modBy) {

	// do the mod
	// if the value is > floor( modBy / 2), the subtract modBy

	//gmp_printf("N = %Zd\n", value);
	mpz_mod( value, value, modBy);

	mpz_t checkValue;
	mpz_init( checkValue);
	mpz_tdiv_q_ui( checkValue, modBy, 2);

	if( mpz_cmp( value, checkValue) == 1) {       // if value > checkValue
		mpz_sub( value, value, modBy);
	} 
	else if ( mpz_cmp_ui( checkValue, 0) == -1) {  // if 0 > checkValue
		mpz_neg( checkValue, checkValue);
		if( mpz_cmp( checkValue, value) == 1) {   // if checkValue > value
			mpz_add( value, value, modBy);
			//gmp_printf("N = %Zd\n", value);
		}
	}
}

// mpz_t convertToMpz( char)

int main() {

	//cra_int();

	mpz_t pls;
	mpz_init( pls);

	char wow[6] = {'1', '2', '3', '4', '5', '6'};

	int i;
	unsigned int cur10 = 1;
	for( i = 5; i >= 0; -- i) {
		mpz_t temp;
		mpz_init( temp);
		mpz_set_ui( temp, (int)(wow[ i] - '0'));

		mpz_mul_ui( temp, temp, cur10);

		mpz_add( pls, pls, temp);
		cur10 *= 10;
	}

	gmp_printf("pls = %Zd\n", pls);


	return 0;
}