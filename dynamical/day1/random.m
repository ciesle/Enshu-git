function [array]=random(seed,n)
array=zeros(n,1);
for i=1:n
    seed=bitxor(seed,bitshift(seed,13,'uint16'),'uint16');
    seed=bitxor(seed,bitshift(seed,-7,'uint16'),'uint16');
    seed=bitxor(seed,bitshift(seed,17,'uint16'),'uint16');
    array(i)=seed;
end
