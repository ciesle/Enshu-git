s=tf('s');
P=2/(s*(s+2));
controlSystemDesigner(P);
%{
  0.23147 (s+1.344) (s+48.56)
  ---------------------------
      (s+3.853) (s+2.447)
%}