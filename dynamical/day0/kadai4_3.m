function [y]=kadai4_3(K,M,D,d)

A1=[0 1; -K/M -D/M];
B1=[0; 1/M];
C1=[1 0];
D1=0;
s1=ss(A1,B1,C1,D1);

s2=ss(0,0,0,10);

s3=ss(0,0,0,1);

s4=[s2,s3];

s5=s1*s4;

s6=ss(0,0,[0; 0],[1; 0]);

s7=feedback(s5,s6,-1);

delta=0.05;
t=0:delta:20;
r(1,:)=ones(1,length(t));
r(2,:)=d;
y=lsim(s7,r,t);