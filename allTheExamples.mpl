# all of the tests
# there are 35 total test problems (although not all of them will probably finish)

read( "moreExamples.mpl"); # 8 examples

theOrds := totOrds;
theBs := totBs;
theExNames := exNames;

read( "suchExamples.mpl"); # 10 examples

theOrds := [op(theOrds), op(totOrds)];
theBs := [op(theBs), op(totBs)];
theExNames := [op(theExNames), op(exNames)];

read( "plsExamples.mpl"); # 17 examples

theOrds := [op(theOrds), op(totOrds)];
theBs := [op(theBs), op(totBs)];
theExNames := [op(theExNames), op(exNames)];


totOrds := theOrds;
totBs := theBs;
exNames := theExNames;