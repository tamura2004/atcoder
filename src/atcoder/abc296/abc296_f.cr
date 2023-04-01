require "crystal/segment_tree"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)
quit "No" if a.sort != b.sort
quit "Yes" if a.uniq.size < n

b = b.zip(a).sort_by(&.last).map(&.first)

st = (n+2).to_st_sum
inv = 0_i64
b.each do |v|
  inv += st[v..]
  st[v] += 1
end

puts inv.even? ? "Yes" : "No"
