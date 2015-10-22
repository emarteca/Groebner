# groebner examples here

with(Groebner):



CG_1 := [8*x^2 - 2*x*y - 6*x*z + 3*x + 3*y^2 - 7*y*z + 10*y + 10*z^2 - 				8*z - 4,

		 10*x^2 - 2*x*y + 6*x*z - 6*x + 9*y^2 - y*z - 4*y - 2*z + 5*z - 9,

		 5*x^2 + 8*x*y + 4*x*z + 8*x + 9*y^2 - 6*y*z + 2*y - z^2 - 7*z + 	5];

Basis( CG_1, tdeg(x, y, z));


CG_2 := [2*(b-1)^2 + 2*(q-p*q+p^2) + (c^2)*(q-1)^2 - 2*b*q + 
			2*c*d*(1-q)*(q-p) + 2*b*p*q*d*(d-c) + (b^2)*(d^2)*(1-2*p) + 2*b*(d^2)*(p-q) + 2*b*d*c*(p-1) + 2*b*p*q*(c+1) + (b^2-2*b)*(p^2)*(d^2) + 2*(b^2)*(p^2) + 4*b*(1-b)*p + (d^2)*(p-q)^2,

		d*(2p+1)*(q-p) + c*(p+2)*(1-q) + b*(b-2)*d + b*(1-2*b)*b*d
		]

#B := [x+y+z, x*y+y*z+z*x, x*y*z-1];

#writeto("basis1.txt"):

# B := [x+y+z, x*y+y*z+z*x, x*y*z-1];
#showtime():
#Basis(B, tdeg(x, y, z)):
#off:


