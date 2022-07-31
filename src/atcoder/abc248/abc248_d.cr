require "crystal/wavelet_matrix"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
mt = a.to_wm

q = gets.to_s.to_i64
q.times do
  l, r, x = gets.to_s.split.map(&.to_i)
  pp mt.rank(x, l.pred...r)
end
