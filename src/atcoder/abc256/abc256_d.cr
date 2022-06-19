require "crystal/range_set"

set = RangeSet.new
n = gets.to_s.to_i64

n.times do
  lo, hi = gets.to_s.split.map(&.to_i64)
  set << (lo...hi)
end

ans = [] of Int64

set.each do |(i, side)|
  ans << i

  if side.hi?
    puts ans.join(" ")
    ans.clear
  end
end
