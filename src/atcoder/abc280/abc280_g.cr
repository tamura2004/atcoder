require "crystal/complex"
require "crystal/modint9"
def len(z, w)
  if 0 <= (z-w).x * (z-w).y
    (z-w).chebyshev
  else
    (z-w).manhattan
  end
end

n, d = gets.to_s.split.map(&.to_i64)
z = Array.new(n) do
  C.read
end

dp = Array.new(n){0.to_m}

n.times do |i|
  cnt = 0
  (0...i).each do |j|
    if len(z[i],z[j]) <= d
      cnt += 1
    end
  end
  dp[i] += 2.to_m ** cnt
end

pp dp
pp dp.sum - 1