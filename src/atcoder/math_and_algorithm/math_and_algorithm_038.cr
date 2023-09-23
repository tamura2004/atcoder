require "crystal/st"

n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).to_st_sum

q.times do
  l, r = gets.to_s.split.map(&.to_i.pred)
  pp a[l..r]
end
