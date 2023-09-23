require "crystal/st"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).to_st_sum
m = gets.to_s.to_i64
b = Array.new(m) { gets.to_s.to_i.pred }

ans = b.each_cons_pair.sum do |lo, hi|
  lo, hi = hi, lo unless lo < hi
  a[lo...hi]
end

pp ans
