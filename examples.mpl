
# disgusting Argborg example
# p. 13 linz 2006

n1 := "Argborg";
ord1 := grlex( v, w, x, y, z);
B1 := [  v + w + x + y + z, 
		v*w + v*z + w*x + x*y + y*z,
		v*w*x + v*w*z + v*y*z + w*x*y + x*y*z,
		v*w*x*y + v*w*x*z + v*w*y*z + v*x*y*z + w*x*y*z,
		v*w*x*y*z - 1];


# "too easy (?)" Katsura example
# p. 14 linz 2006

n2 := "Too-easy Katsura";
ord2 := plex( a, b, c, d, e);
B2 := [  a + 2*b + 2*c + 2*d + 2*e - 1,
		a^2 + 2*b^2 + 2*c^2 + 2*d^2 + 2*e^2 - a,
		2*a*b + 2*b*c + 2*c*d + 2*d*e - b,
		2*a*c + b^2 + 2*b*d + 2*c*e - c,
		2*a*d + 2*b*c + 2*b*e - d];



# Kriber's example ( HOOOOOOOOOOOOOOOOOOOOOOOOOOOOOLY SHIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIT)
# found online (in pls links)
# p. 17 linz 2006

n3 := "Revolting Kriber";

# parameters:  su, sv, mv, Pi
ord3 := plex( a, b, c, d, f, g, su, sv, mv, Pi);

PM0 := -6*c*g^2*su*Pi*sv^5-2*(2*c*d+a+b*d+b+c*d^2+mv*b*f-mv+2
*mv*c*d*f+2*mv*c*f+mv^2*b*g+2*mv^2*c*g+2*mv^2*c*d*g+mv^2*c*f^2+2*mv
^3*c*f*g+c*g^2*mv^4)*su*Pi*sv-2*(b*g+2*c*g+2*c*d*g+c*f^2+6*mv
*c*f*g+6*c*g^2*mv^2)*su*Pi*sv^3-2*c*su^3*Pi*sv;

PM1 := -6*c*g*(2*f+5*g*mv)*su*Pi*sv^5-2*(2*c*d+a+b*d+b+c*d^2+
mv*b*f-mv+2*mv*c*d*f+2*mv*c*f+mv^2*b*g+2*mv^2*c*g+2*mv^2*c*d*g+mv^2
*c*f^2+2*mv^3*c*f*g+c*g^2*mv^4)*mv*su*Pi*sv-2*(b*f-1+2*c*d*f+
2*c*f+3*mv*b*g+6*mv*c*g+6*mv*c*d*g+3*mv*c*f^2+12*mv^2*c*f*g+10*c*g^
2*mv^3)*su*Pi*sv^3-2*mv*c*su^3*Pi*sv;

PM2 := -6*(b*g+2*c*g+2*c*d*g+c*f^2+10*mv*c*f*g+15*c*g^2*mv^2)*su
*Pi*sv^5-2*(2*c*d+a+b*d+b+c*d^2+mv*b*f-mv+2*mv*c*d*f+2*mv*c*f+mv
^2*b*g+2*mv^2*c*g+2*mv^2*c*d*g+mv^2*c*f^2+2*mv^3*c*f*g+c*g^2*mv^4)*
mv^2*su*Pi*sv-2*(a+b-3*mv+6*mv*c*f+15*c*g^2*mv^4+6*mv^2*c*f^2
+12*mv^2*c*g+6*mv^2*b*g+3*mv*b*f+12*mv^2*c*d*g+20*mv^3*c*f*g+6*mv*c
*d*f+b*d+c*d^2+2*c*d)*su*Pi*sv^3-30*c*g^2*su*Pi*sv^7-2*
mv^2*c*su^3*Pi*sv-2*c*su^3*Pi*sv^3;

ME0 := -6*c*g^2*su*Pi*sv^5-2*(a+b*d+c*d^2-mv+mv*b*f+2*mv*c*d*
f+mv^2*b*g+2*mv^2*c*d*g+mv^2*c*f^2+2*mv^3*c*f*g+c*g^2*mv^4)*su*
Pi*sv-2*(b*g+2*c*d*g+c*f^2+6*mv*c*f*g+6*c*g^2*mv^2)*su*Pi*
sv^3-2*c*su^3*Pi*sv;

ME1 := -6*g*(b*g+3*c*d*g+3*c*f^2+15*mv*c*f*g+15*c*g^2*mv^2)*su*
Pi*sv^5-2*(a+b*d+c*d^2-mv+mv*b*f+2*mv*c*d*f+mv^2*b*g+2*mv^2*c*d*
g+mv^2*c*f^2+2*mv^3*c*f*g+c*g^2*mv^4)*(d+f*mv+g*mv^2)*su*Pi*
sv-2*(-f-3*g*mv+3*c*d*f^2+3*mv*c*f^3+18*mv^2*c*d*g^2+30*mv^3*c*f
*g^2+6*g*mv*b*f+18*g*mv*c*d*f+18*g*mv^2*c*f^2+g*a+b*f^2+6*mv^2*b*g^
2+15*c*g^3*mv^4+2*g*b*d+3*g*c*d^2)*su*Pi*sv^3-30*c*g^3*su*
Pi*sv^7-2*(b+3*c*d+3*mv*c*f+3*mv^2*c*g)*su^3*Pi*sv-6*c*g*
su^3*Pi*sv^3;

ME2 := -2*(a+b*d+c*d^2-mv+mv*b*f+2*mv*c*d*f+mv^2*b*g+2*mv^2*c*d*g+
mv^2*c*f^2+2*mv^3*c*f*g+c*g^2*mv^4)*(d+f*mv+g*mv^2)^2*su*Pi*
sv-2*(-6*mv*g*d+120*mv^3*c*d*f*g^2+12*mv*c*d*f^3+60*mv^4*c*d*g^3
+40*mv^3*c*f^3*g+90*mv^4*c*f^2*g^2+84*mv^5*c*f*g^3+6*a*g*f*mv+18*b*
d*g*f*mv+18*b*d*g^2*mv^2+36*c*d^2*g*f*mv+36*c*d^2*g^2*mv^2+18*mv^2*
b*f^2*g+30*mv^3*b*f*g^2+72*mv^2*c*d*f^2*g+a*f^2-10*g^2*mv^3-3*mv*f^
2-2*d*f+3*b*d^2*g+3*b*d*f^2+4*c*d^3*g+6*c*d^2*f^2-12*g*f*mv^2+3*mv*
b*f^3+15*mv^4*b*g^3+6*mv^2*c*f^4+28*c*g^4*mv^6+2*a*g*d+6*a*g^2*mv^2
)*su*Pi*sv^3-6*(12*g*c*d*f^2+20*g*mv*c*f^3+15*g^2*mv*b*f+60*g
^2*mv*c*d*f+60*g^3*mv^2*c*d+90*g^2*mv^2*c*f^2+140*g^3*mv^3*c*f+g^2*
a-5*g^2*mv-2*g*f+c*f^4+3*g^2*b*d+6*g^2*c*d^2+15*g^3*mv^2*b+70*g^4*c
*mv^4+3*g*b*f^2)*su*Pi*sv^5-210*c*g^4*su*Pi*sv^9-30*g^2
*(b*g+4*c*d*g+6*c*f^2+28*mv*c*f*g+28*c*g^2*mv^2)*su*Pi*sv^7-2
*(a+3*b*d+6*c*d^2-mv+3*mv*b*f+12*mv*c*d*f+3*mv^2*b*g+12*mv^2*c*d*g+
6*mv^2*c*f^2+12*mv^3*c*f*g+6*c*g^2*mv^4)*su^3*Pi*sv-6*(b*g+4*
c*d*g+2*c*f^2+12*mv*c*f*g+12*c*g^2*mv^2)*su^3*Pi*sv^3-36*c*g^
2*su^3*Pi*sv^5-6*c*su^5*Pi*sv;

B3 := [ PM0, PM1, PM2, ME0, ME1, ME2];



# Trinks problem
# Dekleine paper, p. 5

n4 := "Trinks from Dekleine";

ord4 := tdeg( b, s, p, t, z, w);

B4 := [  45*p + 35*s - 165*b - 36,
		35*p + 40*z + 25*t - 27*s,
		15*w + 25*p*s + 30*z - 18*t - 165*b^2,
		-9*w + 15*p*t + 20*z*s,
		w*p + 2*z*t - 11*b^3,
		99*w - 11*s*b + 3*b^2];





totOrds := [ ord1, ord2, ord4];
totBs := [ B1, B2, B4];
exNames := [ n1, n2, n4];


n1 := "testing";
#ord1 := plex( x, y);
#B1 := [x^3 - 3*x*y, y*x^2 - 2*y^2 + x];

totOrds := [ ord1];
totBs := [ B1];
exNames := [ n1];








