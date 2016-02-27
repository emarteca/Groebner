# arnborgII
# arnborgIII
# arnborgV
# forsman2
# forsman3
# cyclic6
# cyclic7
# cyclic8
# cyclic9
# hcyclic8
# katsura7
# katsura8
# katsura9
# katsura10
# repulso1
# repulso2
# repulso3


# arnborgII --------------------------------------------------------------

n1 := "arnborgII";

read( "problems/arnborgII");
ord1 := tdeg( op( X));
B1 := F;


# arnborgIII --------------------------------------------------------------

n2 := "arnborgIII";

read( "problems/arnborgIII");
ord2 := tdeg( op( X));
B2 := F;

# arnborgV --------------------------------------------------------------

n3 := "arnborgV";

read( "problems/arnborgV");
ord3 := tdeg( op( X));
B3 := F;

# forsman2 --------------------------------------------------------------

n4 := "forsman2";

read( "problems/forsman2");
ord4 := tdeg( op( X));
B4 := F;

# forsman3 --------------------------------------------------------------

n5 := "forsman3";

read( "problems/forsman3");
ord5 := tdeg( op( X));
B5 := F;

# cyclic6 --------------------------------------------------------------

n6 := "cyclic6";

read( "problems/cyclic6");
ord6 := tdeg( op( X));
B6 := F;

# cyclic7 --------------------------------------------------------------

n7 := "cyclic7";

read( "problems/cyclic7");
ord7 := tdeg( op( X));
B7 := F;

# cyclic8 --------------------------------------------------------------

n8 := "cyclic8";

read( "problems/cyclic8");
ord8 := tdeg( op( X));
B8 := F;

# cyclic9 --------------------------------------------------------------

n9 := "cyclic9";

read( "problems/cyclic9");
ord9 := tdeg( op( X));
B9 := F;

# hcyclic8 --------------------------------------------------------------

n10 := "hcyclic8";

read( "problems/hcyclic8");
ord10 := tdeg( op( X));
B10 := F;

# katsura7 --------------------------------------------------------------

n11 := "katsura7";

read( "problems/katsura7");
ord11 := tdeg( op( X));
B11 := F;

# katsura8 --------------------------------------------------------------

n12 := "katsura8";

read( "problems/katsura8");
ord12 := tdeg( op( X));
B12 := F;

# katsura9 --------------------------------------------------------------

n13 := "katsura9";

read( "problems/katsura9");
ord13 := tdeg( op( X));
B13 := F;

# katsura10 --------------------------------------------------------------

n14 := "katsura10";

read( "problems/katsura10");
ord14 := tdeg( op( X));
B14 := F;

# repulso1 --------------------------------------------------------------

n15 := "repulso1";

read( "problems/repulso1");
ord15 := tdeg( op( X));
B15 := F;

# repulso2 --------------------------------------------------------------

n16 := "repulso2";

read( "problems/repulso2");
ord16 := tdeg( op( X));
B16 := F;

# repulso3 --------------------------------------------------------------

n17 := "repulso3";

read( "problems/repulso3");
ord17 := tdeg( op( X));
B17 := F;





totOrds := [ ord1, ord2, ord3, ord4, ord5, ord6, ord7, ord8, ord9, ord10, ord11, ord12, ord13, ord14, ord15, ord16, ord17];
totBs := [ B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16, B17];
exNames := [ n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17];


# more reasonable set that actually finishes
totOrds := [ ord1, ord2, ord3, ord4, ord5, ord6, ord11];
totBs := [ B1, B2, B3, B4, B5, B6, B11];
exNames := [ n1, n2, n3, n4, n5, n6, n11];