M=1.75;
g=9.8;
i0=1.21;
k=ureal('k',2.9e-4,'range',[2.53e-4,3.35e-4]);
L=ureal('L',5.1e-1,'range',[4.65e-1,5.57e-1]);
R=ureal('R',2.32e1,'range',[2.27e1,2.37e1]);
x0=ureal('x0',5.0e-3,'range',[4.5e-3,5.5e-3]);
Ki=2*k*i0/(x0*x0);
Kx=2*k*(i0*i0)/(x0*x0*x0);
rng(0);

s=tf('s');

K=(48*s*s*s*s-7.2e8*s*s*s-8.8e10*s*s-3.1e12*s-2.7e13)/(s*s*s*s+1.5e3*s*s*s+8.0e5*s*s+1.9e8*s+1.8e7);
Parray=usample(-Ki/((M*s*s-Kx)*(L*s+R)),50);
Pnom=kadai2(s);

time=0:0.001:1;
ref=zeros(2,length(time));
ref(2,:)=-28;

s1=ss(0,0,0,1);

Lnom=Pnom*K;
Larray=Parray*K;
%x=P(d-Kx)
%(1+PK)x=Pd
%x=P/(1+PK)d
Tnom=minreal([Lnom/(1+Lnom), Pnom/(1+Pnom*K)]);
Tarray=minreal([Larray/(1+Larray), Parray/(1+Parray*K)]);

figure
for i = 1:50
    [yhi,t]=lsim(Tarray(:,:,i),ref,time);
    plot(t,yhi,'b','LineWidth',1);
    hold on;
end
[yhi1,t]=lsim(Tnom,ref,time);
plot(t,yhi1,'r','LineWidth',1);
grid on;
set(findall(gcf,'type','Axes'),'FontSize',18);
xlabel('Time [s]');
ylabel('Angular Velocity [rad/s]');