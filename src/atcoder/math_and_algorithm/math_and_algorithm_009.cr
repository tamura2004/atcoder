n, s = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

# dp = make_array(false, s + 1)
# dp[0] = true

# n.times do |i|
#   (0..s).reverse_each do |j|
#     break if j - a[i] < 0
#     dp[j] ||= dp[j - a[i]]
#   end
# end

# puts dp[-1] ? "Yes" : "No"

require "big"
dp = 1.to_big_i

n.times do |i|
  dp |= (dp << a[i])
end

puts dp.bit(s) == 1 ? "Yes" : "No"
