require "crystal/indexable"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
q, r = a.sum.divmod(n)

a.map!(&.- q)
s = a.cs

if r.zero?
  quit s.map(&.abs).sum
end

dp = make_array(Int64::MAX, n + 1, n + 1)
dp[0][0] = 0_i64
n.times do |i|
  (0..i).each do |j|
    chmin dp[i + 1][j], dp[i][j] + (s[i + 1] - j).abs
    chmin dp[i + 1][j + 1], dp[i][j] + (s[i + 1] - j - 1).abs
  end
end

pp dp[-1][r]

a = gets.to_s.to_i64
b, c = gets.to_s.split.map(&.to_i64)
s = gets.to_s
puts "#{a + b + c} #{s}"
