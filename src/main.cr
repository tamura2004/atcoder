n = gets.to_s.to_i
a = Array.new(n){ gets.to_s.to_i64 }
ans = 0_i64
(n-1).times do |i|
  j = Math.min(a[i],a[i+1])
  ans += j
  a[i] -= j
  a[i+1] -= j
end
pp ans