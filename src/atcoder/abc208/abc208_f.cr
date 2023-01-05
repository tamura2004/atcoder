require "crystal/lagrange_polynomial"

MOD = 1e9.to_i64 + 7

n,m,k = gets.to_s.split.map(&.to_i64)
dp = Array.new(m+1) do
  Array.new(m+k+1, 0_i64)
end

(m + k + 1).times do |x|
  dp[0][x] = x.to_m ** k
end

(1..m).each do |y|
  (1..m+k).each do |x|
    dp[y][x] = dp[y-1][x] + dp[y][x-1]
  end
end

y = dp[-1]
dp = nil
ans = LagrangePolynomial.new(y, n).solve
pp ans
