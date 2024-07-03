function [y]=kadai4_4(K,M,D,d)

A1=[0 1; -K/M -D/M];
B1=[0; 1/M];
C1=[1 0];
D1=0;
s1=ss(A1,B1,C1,D1);

s2=ss(0,0,0,-0.3);

s3=ss([0 1;0 0],[0.5; 0],[1 0],0);

s4=s2+s3;

s5=ss(0,0,0,1);

s6=[s4,s5];

s7=s1*s6;

s8=ss(0,0,[0;0],[1;0]);

s9=feedback(s7,s8,-1);

delta=0.05;
t=0:delta:20;
r(1,:)=ones(1,length(t));
r(2,:)=d;
y=lsim(s9,r,t);