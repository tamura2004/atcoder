n, p, q, r, s = gets.to_s.split.map(&.to_i64.pred)
a = gets.to_s.split.map(&.to_i64)
a[p..q], a[r..s] = a[r..s], a[p..q]
puts a.join(" ")
