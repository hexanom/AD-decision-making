function [ G ] = matricegain( x1, x2, x3, x4, x5, f1, f2, f3, f4, f5 )
%MATRICEGAIN Summary of this function goes here
%   Detailed explanation goes here

G = zeros(5);

G(1, 1) = sum(x1' .* f1);
G(1, 2) = sum(x1' .* f2');
G(1, 3) = sum(x1' .* f3);
G(1, 4) = x1(1) + x1(2) + x1(3) - x1(4) - x1(5) - x1(6);
G(1, 5) = sum(x1' .* f5);

G(2, 1) = sum(x2' .* f1);
G(2, 2) = sum(x2' .* f2');
G(2, 3) = sum(x2' .* f3);
G(2, 4) = x2(1) + x2(2) + x2(3) - x2(4) - x2(5) - x2(6);
G(2, 5) = sum(x2' .* f5);

G(3, 1) = sum(x3' .* f1);
G(3, 2) = sum(x3' .* f2');
G(3, 3) = sum(x3' .* f3);
G(3, 4) = x3(1) + x3(2) + x3(3) - x3(4) - x3(5) - x3(6);
G(3, 5) = sum(x3' .* f5);

G(4, 1) = sum(x4' .* f1);
G(4, 2) = sum(x4' .* f2');
G(4, 3) = sum(x4' .* f3);
G(4, 4) = x4(1) + x4(2) + x4(3) - x4(4) - x4(5) - x4(6);
G(4, 5) = sum(x4' .* f5);

G(5, 1) = sum(x5' .* f1);
G(5, 2) = sum(x5' .* f2');
G(5, 3) = sum(x5' .* f3);
G(5, 4) = x5(1) + x5(2) + x5(3) - x5(4) - x5(5) - x5(6);
G(5, 5) = sum(x5' .* f5);

G = abs(G);

end

