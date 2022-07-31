a,b,k = gets.to_s.split.map(&.to_i64)
ans = 0
while a < b
  a *= k
  ans += 1
end
pp ans