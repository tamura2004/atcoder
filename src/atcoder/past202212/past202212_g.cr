require "crystal/indexable"
require "crystal/segment_tree"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
cs = a.cs
st = cs.to_st_min
ans = Int64::MIN

n.times do |i|
  chmax ans, cs[i+1] - st[..i]
end

pp ans