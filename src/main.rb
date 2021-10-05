n = gets.to_i
a = gets.split.map(&:to_i).sort

ans = 0
while a.max >= n
  b = a.map { _1 / n }
  s = b.sum
  ans += s

  n.times do |i|
    a[i] -= b[i] * n
    a[i] += s - b[i]
  end
end

pp ans
