def f(x, k)
  r = 10_i64 ** k
  (x + r * 5) // (r * 10) * (r * 10)
end

x, k = gets.to_s.split.map(&.to_i64)

k.times do |i|
  x = f(x, i)
end

pp x
