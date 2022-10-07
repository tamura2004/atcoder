require "crystal/segment_tree"

s = gets.to_s.chars.map(&.ord.- 'a'.ord)
n = s.size
ix = Array.new(26, 0)
pre = [] of Int32
st = SegmentTree(Int32).sum(n + 1)
st[0] = 1

n.times do |i|
  st[i + 1] += st[ix[s[i]]..i]
  ix[s[i]] = i + 1
end

pp st[1..]

pp ix
pp st
