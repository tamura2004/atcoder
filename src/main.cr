require "crystal/mod_int"
require "crystal/matrix"

n, b, _ = gets.to_s.split.map(&.to_i)
c = gets.to_s.split.map(&.to_i64)

a = [0.to_m] * b
c.each { |v| a[v%b] += 1 }

m = Matrix(ModInt).zero(b)

b.times do |i|
  c.each do |j|
    jj = (i*10 + j) % b
    m[jj, i] += 1
  end
end

ans = m ** (n-1) * a
pp ans[0]

# dp = (0..n).map { [0_i64] * b }
# dp[0][0] = 1_i64

# n.times do |i|
#   b.times do |j|
#     c.each do |k|
#       nex = (j*10+k)%b
#       dp[i+1][nex] += dp[i][j]
#     end
#   end
# end

# pp dp[-1][0]
