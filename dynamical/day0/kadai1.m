
delta=0.05;
t=0:delta:20;

hold off;
y1=func(-0.5,1);
plot(t,y1,'r')
hold on;
y2=func(1,1);
plot(t,y2,'b')
hold on;
y3=func(3,1);
plot(t,y3,'g')
hold on;
y4=func(10,1);
plot(t,y4,'m')
hold on;
legend("k1=-0.5","k1=1","k1=3","k1=10");

function [y]=func(k1,k2)
K=1;
M=1;
D=1;

A1=[0 1; -K/M -D/M];
B1=[0; 1/M];
C1=[1 0; 0 1];
D1=[0; 0];

A2=0;
B2=[0 0];
C2=0;
D2=[k1 k2];

s1=ss(A1,B1,C1,D1);
s2=ss(A2,B2,C2,D2);
s3=feedback(s1,s2,-1);

s4=ss(0,[0 0],0,[1 0])*s3;

delta=0.05;
t=0:delta:20;
r=1*ones(1,length(t));
y=lsim(s4,r,t);
end

