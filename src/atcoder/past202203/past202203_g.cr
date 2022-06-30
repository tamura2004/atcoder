a, b, c = gets.to_s.split.map(&.to_i64)
ans = (1.0..2.0).bsearch do |x|
  0 <= x**5*a + x*b + c
end
pp ans
