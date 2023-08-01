function [g,h] = fibocert(a,b)
% $Revision: 1.1 $
% Part 1 contains an assertion
mbreal(a); % Assert that "a" contains only real numbers.
n = max(size(a));
g = zeros(1,n);
g(1) = a(1);
g(2) = a(2);
for c = 3:n
g(c) = g(c - 1) + g(c - 2) + a(c);
end
% Part 2 contains no assertions
n = max(size(b));
h = zeros(1,n);
h(1) = b(1);
h(2) = b(2);
for c = 3:n
h(c) = h(c - 1) + h(c - 2) + b(c);
end