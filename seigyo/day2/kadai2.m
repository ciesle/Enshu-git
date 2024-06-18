function [Pnom]=kadai2(s)
M=1.75;
g=9.8;
i0=1.21;
k=2.9e-4;
L=5.1e-1;
R=2.32e1;
x0=5.0e-3;
Ki=2*k*i0/x0.^2;
Kx=2*k*i0.^2/x0.^3;

Pnom=-Ki/((M*s*s-Kx)*(L*s+R));
