require "crystal/lagrange_polynomial"

n = gets.to_s.to_i64
y = gets.to_s.split.map(&.to_i64)
t = gets.to_s.to_i64

ans = LagrangePolynomial.new(y, t).solve
pp ans
