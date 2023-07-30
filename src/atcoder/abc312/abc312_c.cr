require "crystal/indexable"

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort
b = gets.to_s.split.map(&.to_i64).sort

ans = (0_i64..Int64::MAX).bsearch do |x|
  a.count_less_or_equal(x) >= b.count_more_or_equal(x)
end

pp ans
