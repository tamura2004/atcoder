require "crystal/indexable"

n, q = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64).sort

q.times do
  x = gets.to_s.to_i64
  pp a.count_more_or_equal(x)
end
