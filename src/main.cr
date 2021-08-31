require "crystal/boston_mori"
n = gets.to_s.to_i64
a = [1, 0, 0, 0, 1, 1, 3]
b = [1, -1, -2, 0, 2, 4, -1, -3, -3, -1, 4, 2, 0, -2, -1, 1]
ans = BostonMori.new(a, b).solve(n-6)
pp ans

# (1 + x^4 + x^5 + 3 x^6)/(1 - x - 2 x^2 + 2 x^4 + 4 x^5 - x^6 - 3 x^7 - 3 x^8 - x^9 + 4 x^10 + 2 x^11 - 2 x^13 - x^14 + x^15)
