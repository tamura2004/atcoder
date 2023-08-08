x, k = gets.to_s.split.map(&.to_i64)
k.times do |i|
  y = 10_i64 ** i.succ
  r = x % y
  q = r // 10_i64 ** i
  x += y if 5 <= q
  x -= r
end
pp x