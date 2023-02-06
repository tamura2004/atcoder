require "crystal/modint9"
require "crystal/segment_tree"

# (1 2)
#
# (1 23)
# (2 3) 2 = 1 * 2
#
# (1 234)
# (2 34)
# (29 4)

n = gets.to_s.to_i
a = gets.to_s.chars.map(&.to_i.to_m)
dp = Array.new(n + 1, 0.to_m).to_st_sum
dp[0] = 1.to_m
dp[1] = a[0]

(1...n).each do |i|
  dp[i + 1] = dp[i] * 10 + dp[..i] * a[i]
end

acc = [] of ModInt
a.reverse.each_with_index do |v, i|
  if i.zero?
    acc << v
  else
    acc << acc[-1] + v * 10.to_m ** i
  end
end
acc.reverse!

ans = 0.to_m
n.times do |i|
  ans += dp[i] * acc[i]
end
pp ans
