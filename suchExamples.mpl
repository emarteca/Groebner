# arnborgI (given F and X)
# arnborgIII (given F and X)
# forsman4 (given F and X)
# hell-in (given F and X)
# kiyoshi5 (given F and X)
# p34 (given F and X)


# arnborgI (given F and X) --------------------------------------------------------------

n1 := "arnborgI";

read( "problems/arnborgI");
ord1 := tdeg( op( X));
B1 := F;


# arnborgIII (given F and X) ------------------------------------------------------------

n2 := "arnborgIII";

read( "problems/arnborgIII");
ord2 := tdeg( op( X));
B2 := F;


# forsman4 (given F and X) --------------------------------------------------------------

n3 := "forsman4";

read( "problems/forsman4");
ord3 := tdeg( op( X));
B3 := F;


# hell-in (given F and X) ---------------------------------------------------------------

n4 := "hell-in";

read( "problems/hell-in");
ord4 := tdeg( op( X));
B4 := F;

# hell-in (given F and X) ---------------------------------------------------------------

n10 := "hell-in";

#read( "problems/hell-in");
ord10 := plex( op( X));
B4 := F;


# kiyoshi5 (given F and X) --------------------------------------------------------------

n5 := "kiyoshi5";

read( "problems/kiyoshi5");
ord5 := tdeg( op( X));
B5 := F;


# p34 (given F and X) -------------------------------------------------------------------

n6 := "p34";

read( "problems/p34");
ord6 := tdeg( op (X));
B6 := F;

# huygens3 (given F and vars) -----------------------------------------------------------

n7 := "huygens3";
read( "problems/huygens3");
ord7 := plex( op( vars));
B7 := F;

# p17 (given F and X) -------------------------------------------------------------------

n8 := "p17";
read( "problems/p17");
ord8 := plex( op( vars));
B8 := F;

# p33 (given F and X) -------------------------------------------------------------------

n9 := "p33";
read( "problems/p33");
ord9 := plex( op( vars));
B9 := F;

# the 10 is above






totOrds := [ ord1, ord2, ord3, ord4, ord5, ord6, ord7, ord8, ord9, ord10];
totBs := [ B1, B2, B3, B4, B5, B6, B7, B8, B9, B10];
exNames := [ n1, n2, n3, n4, n5, n6, n7, n8, n9, n10];