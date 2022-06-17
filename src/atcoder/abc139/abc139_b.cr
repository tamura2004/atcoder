# 二分探索で解いてみる
a, b = gets.to_s.split.map(&.to_i64)
ans = (0..100).bsearch do |i|
  b <= 1 + (a - 1) * i
end
pp ans