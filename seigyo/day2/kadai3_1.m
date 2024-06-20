M=1.75;
g=9.8;
i0=1.21;
k=2.9e-4;
L=5.1e-1;
R=2.32e1;
x0=5.0e-3;
Ki=2*k*i0/x0.^2;
Kx=2*k*i0.^2/x0.^3;

s=tf('s');

K=(48*s*s*s*s-7.2e8*s*s*s-8.8e10*s*s-3.1e12*s-2.7e13)/(s*s*s*s+1.5e3*s*s*s+8.0e5*s*s+1.9e8*s+1.8e7);
P=-Ki/((M*s*s-Kx)*(L*s+R));

L=P*K;

opts = bodeoptions; 
opts.PhaseWrapping = 'on';
opts.PhaseWrappingBranch = -360;

bodeplot(L,{1e-1,1e3},'b',opts);
%nyquist(L)
set(findall(gcf,'type','Line'),'LineWidth',1);
set(findall(gcf,'type','Axes'),'FontSize',16);
grid on;