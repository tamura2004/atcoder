t = gets.to_s.to_i64
t.times do
  a = gets.to_s.split.map(&.to_i64)
  p = gets.to_s.split.map(&.to_i64)

  num = a.sum
  tot = a.zip(1..).sum { |i, j| i * j }

  need = num * 3 - tot

  if need <= 0
    pp 0
  else
    x = need.odd? ? 1 : 0
    y = need // 2

    ans = y * Math.min(p[3] * 2, p[4]) + x * Math.min(p[3], p[4])
    pp ans 
  end
end
