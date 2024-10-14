k=2.9e-4;
L=5.1e-1;
R=2.32e1;
x0=5.0e-3;

Ki=2*k*i0/x0.^2;
Kx=2*k*i0.^2/x0.^3;
figure
s=tf('s');
Pnom=-Ki/((M*s*s-Kx)*(L*s+R));
bode(Pnom, logspace(-1,3),'b');
set(findall(gcf,'type','Line'),'LineWidth',4);
set(findall(gcf,'type','Axes'),'FontSize',16);
grid on