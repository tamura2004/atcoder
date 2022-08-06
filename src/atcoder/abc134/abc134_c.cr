require "crystal/segment_tree"
n = gets.to_s.to_i64
a = Array.new(n) { gets.to_s.to_i64 }
st = a.to_st_max

n.times do |i|
  puts Math.max st[...i], st[i + 1..]
end
