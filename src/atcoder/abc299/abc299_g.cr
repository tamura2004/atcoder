require "crystal/st"

n,m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i.pred)

g = Array.new(m) { [] of Int32 }
a.each_with_index do |v, i|
  g[v] << i
end

mins = a.zip(0..).to_st_min

left = Array.new(n, Int32::MAX).to_st_min
g.each_with_index do |arr, i|
  left[arr[-1]] = arr[-1]
end

ans = [] of Int32 | Int64
lo = 0
loop do
  i = left[0..]
  j, ix = mins[lo..i]
  ans << j
  lo = ix

  quit ans.map(&.succ).join(" ") if ans.size == m

  left[g[j][-1]] = Int32::MAX
  g[j].each{|k| mins[k] = {Int32::MAX, Int32::MAX} }
end

puts left