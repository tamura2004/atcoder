require "crystal/mod_int"
require "crystal/segment_tree"

s = gets.to_s
n = s.size

pre = Array.new(n.succ){Hash(Char,Int32).new(0)}
n.times do |i|
  pre[i].each do |k,v|
    pre[i.succ][k] = v
  end
  pre[i.succ][s[i]] = i.succ
end

dp = Array.new(n.succ, 0.to_m).to_st_sum
dp[0] = 1.to_m
dp[1] = 1.to_m

n.times do |i|
  next if i.zero?

  lo = pre[i][s[i]]
  hi = i - 1
  pp! [i,lo,hi]
  next if lo > hi
  dp[i.succ] = dp[lo..hi]
end
pp pre
pp dp
pp dp[0..].-(1).to_m
