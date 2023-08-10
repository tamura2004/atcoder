n, k = gets.to_s.split.map(&.to_i64)
k.times do |i|
  n //= 10_i64 ** i
  q, r = n.divmod(10)
  n = (r < 5 ? q : q + 1) * 10
  n *= 10_i64 ** i
end
pp n
