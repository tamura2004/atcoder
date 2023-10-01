require "crystal/st"
n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64.pred)
st = n.to_st_min

a.each do |v|
  st[v] = v
end

n.times do |i|
  pp st[i..] - i
end
