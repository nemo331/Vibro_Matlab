function g = squibo(n)
% This function calculates the first n "squibonacci" numbers.
% $Revision: 1.1 $
%
g = zeros(1,n);
g(1)=1;
g(2)=1;
for i=3:n
g(i) = sqrt(g(i-1)) + g(i-2);
end