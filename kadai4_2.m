function [y]=kadai4_2(K,M,D,d)

A1=[0 1; -K/M -D/M];
B1=[0; 1/M];
C1=[1 0];
D1=0;
s1=ss(A1,B1,C1,D1);

s2=ss(0,0,0,-1);

s3=feedback(s1,s2,-1);

delta=0.05;
t=0:delta:20;
r=ones(1,length(t));
y=lsim(s3,r,t);