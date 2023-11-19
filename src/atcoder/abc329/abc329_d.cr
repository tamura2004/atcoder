# tuple st
require "crystal/st"

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i.pred)

st = Array.new(n) do |i|
  {0_i64, -i}
end.to_st_max

# st[2] = {2_i64, -2}
# pp st[0..]

a.each do |i|
  v, _ = st[i]
  st[i] = ({ v + 1, -i })

  _, j = st[0..]
  puts -j + 1
end