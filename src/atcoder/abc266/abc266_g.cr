# 全ての組み合わせは、(r+g+b).c(r) * (g+b).c(g)
# ここからrgがk個以外を引いていこう
# f(n) := rgがn個連続する（またはn個以下）

require "crystal/modint9"
require "crystal/fact_table"

r,g,b,k = gets.to_s.split.map(&.to_i64)

m = r + g + b - k * 2

pa = 0.to_m
(0..k+1).each do |i|
  pa += (m-1).c(i)
end




# n = r+g+b

# # n個の連続したマスに、隣接せずにk個駒を置く場合の数
# def f(n, k)
#   dp = make_array(0.to_m, n, 2)
#   dp[0][1] = 1.to_m

#   (1...n).each do |i|
#     2.times do |j|
#       2.times do |jj|
#         next if j == 1 && jj == 1
#         dp[i][jj] += dp[i-1][j] + jj
#       end
#     end
#   end
#   pp dp
#   dp[-1]
# end

# pp f(4,2)

ms = [] of 
def pf(n, max, a)
  if n.zero?
