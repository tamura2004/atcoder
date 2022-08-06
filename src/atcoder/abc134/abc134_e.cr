# 最長減少部分列

require "crystal/indexable"
require "crystal/segment_tree"

n = gets.to_s.to_i64
a = Array.new(n){gets.to_s.to_i64}.compress
st = (a.max+1).to_st_max

a.each_with_index do |v, i|
  st[v] = st[v..] + 1
end

pp st[0..]