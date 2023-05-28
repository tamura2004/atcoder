require "crystal/segment_tree"
require "crystal/mod_int"

s = gets.to_s
n = s.size

post = Array.new(n.succ) { Hash(Char,Int32).new(n) }
(0...n).reverse_each do |i|
  post[i+1].each do |k, v|
    post[i][k] = v
  end
  post[i][s[i]] = i
end

dp = Array.new(n.succ) { Hash(Char,ModInt).new(0.to_m) }
n.times do |i|
  ('a'..'z').each do |c|
    ii = post[i][c]
    ii = post[ii][c] if i < n && i.succ == ii
    dp[ii][c] += dp[i][]

pp post
