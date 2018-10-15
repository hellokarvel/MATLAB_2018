function  getI()
%   ;   ask for I;

Z_l=input('Please enter the real and imaginary part of the inductance as a 1X2 array:');
Z_c=input('Please enter the real and imaginary part of the capacitance as a 1X2 array:');
Z_r=input('Please enter the resistor:');
V=input('Please enter real and imaginary part of the sinusoidally varying voltage source as a 1X2 array:');

Z_t = Z_l+Z_c+Z_r;
%V=I*Zt;   I=V/Zt;
a=Z_t*Z_t';
I_real=(V*Z_t')/a;
b=V(2)*Z_t(1)-V(1)*Z_t(2);
I_imag=b/a;
 fprintf('Z_l=%6.2f+%6.2fj\nZ_c=%6.2f+%6.2fj\nZ_r=%6.2f+%6.2fj\n  V=%6.2f+%6.2fj\n',Z_l(1),Z_l(2),Z_c(1),Z_c(2),Z_r(1),Z_r(2),V(1),V(2))
 fprintf('  I=%6.2f+%6.2fj',I_real,I_imag)
end


>> chapter3_322
Please enter the real and imaginary part of the inductance as a 1X2 array:[0 5]
Please enter the real and imaginary part of the capacitance as a 1X2 array:[0 -15]
Please enter the resistor:[5 0]
Please enter real and imaginary part of the sinusoidally varying voltage source as a 1X2 array:[10 0]
Z_l=  0.00+  5.00j
Z_c=  0.00+-15.00j
Z_r=  5.00+  0.00j
  V= 10.00+  0.00j
  I=  0.40+  0.80j>> 
