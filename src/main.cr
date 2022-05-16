# 平面走査
require "crystal/segment_tree"

n,m,q = gets.to_s.split.map(&.to_i)

enum E
  Rails
  Towns
end

alias Event = Tuple(Int32,E,Int32,Int32)
events = [] of Event

m.times do
  l,r = gets.to_s.split.map(&.to_i.pred)
  events << {r,E::Rails,l,-1}
end

q.times do |i|
  l,r = gets.to_s.split.map(&.to_i.pred)
  events << {r,E::Towns,l,i}
end

events.sort!
ans = Array.new(q, 0_i64)
st = ST(Int64).sum(n)

events.each do |hi,type,lo,i|
  case type
  when .rails?
    st[lo] += 1
  when .towns?
    ans[i] = st[lo..hi]
  end
end

puts ans.join("\n")