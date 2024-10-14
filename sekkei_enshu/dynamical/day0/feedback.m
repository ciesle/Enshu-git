function [y]=feedback(K,M,D,T,t)

A1=inv(T)*[0 1; -K/M -D/M]*T;
B1=inv(T)*[0; 1/M];
C1=[1 0; 0 1]*T;
D1=[0; 0];

k1=1;
k2=1;

A2=0;
B2=[0 0];
C2=0;
D2=[k1 k2];

s1=ss(A1,B1,C1,D1);
s2=ss(A2,B2,C2,D2);
s3=feedback(s1,s2,-1);

s4=ss(0,[0 0],0,[1 0])*s3;

r=1*ones(1,length(t));
%r=zeros(1,length(t));r(1,1)=1/0.05;
y=lsim(s4,r,t);
