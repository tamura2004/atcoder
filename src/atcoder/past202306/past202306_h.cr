require "crystal/range"
# 三角数を二分探索

x = gets.to_s.to_i64
ans = (1_i64..2e9.to_i64).reverse_bsearch do |n|
  n * (n + 1) // 2 <= x
end
pp ans