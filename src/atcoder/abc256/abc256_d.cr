# ライブラリ版
# require "crystal/range_set"

# set = RangeSet.new
# n = gets.to_s.to_i64

# n.times do
#   lo, hi = gets.to_s.split.map(&.to_i64)
#   set << (lo...hi)
# end

# ans = [] of Int64

# set.each do |(i, side)|
#   ans << i

#   if side.hi?
#     puts ans.join(" ")
#     ans.clear
#   end
# end

# 始点でソートして貪欲

n = gets.to_s.to_i
a = Array.new(n) do
  lo, hi = gets.to_s.split.map(&.to_i)
  {lo,hi}
end
a.sort!

ans = [] of Tuple(Int32,Int32)

a.each do |lo, hi|
  case
  when ans.empty?
    ans << {lo, hi}
  when lo <= ans[-1][1] && ans[-1][1] < hi
    pre_lo, pre_hi = ans.pop
    ans << {pre_lo, hi}
  when ans[-1][1] < lo
    ans << {lo, hi}
  end
end

ans.each do |lo,hi|
  puts "#{lo} #{hi}"
end


