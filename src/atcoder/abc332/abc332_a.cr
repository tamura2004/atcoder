n,s,k = gets.to_s.split.map(&.to_i64)
ans = 0_i64
n.times do
  p, q = gets.to_s.split.map(&.to_i64)
  ans += p * q
end
ans += k if ans < s
pp ans