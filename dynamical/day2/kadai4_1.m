function [y]=kadai4_1(K,M,D,d)

A1=[0 1; -K/M -D/M];
B1=[0; 1/M];
C1=[1 0];
D1=0;
s1=ss(A1,B1,C1,D1);

A2=[0 1; -2 -2];
B2=[0; 1];
C2=[0 -2.4];
D2=2;
s2=ss(A2,B2,C2,D2);

s3=ss(0,0,0,1);

s4=[s2,s3];

s5=s1*s4;

delta=0.05;
t=0:delta:20;
r(1,:)=ones(1,length(t));
r(2,:)=d;
y=lsim(s5,r,t);