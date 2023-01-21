n, p, q, r, s = gets.to_s.split.map(&.to_i64.pred)
a = gets.to_s.split.map(&.to_i64)

(p..q).to_a.zip(r..s).each do |i,j|
  a.swap i, j
end

puts a.join(" ")