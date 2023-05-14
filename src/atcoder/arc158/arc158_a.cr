t = gets.to_s.to_i64
t.times do
  a,b,c = gets.to_s.split.map(&.to_i64).sort
  # 平均値が整数である
  sum = a + b + c
  ave = sum // 3
  aa = (a - ave).abs
  bb = (b - ave).abs
  cc = (c - ave).abs
  if sum.divisible_by?(3) && aa.even? && bb.even? && cc.even?
    puts (aa + bb + cc) // 4
  else
    puts -1
  end
end
