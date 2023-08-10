x, k = gets.split.map(&:to_i)
k.times do |i|
  y = 10 ** (i + 1)
  r = x % y
  q = r / 10 ** i
  x += y if 5 <= q
  x -= r
end
pp x
