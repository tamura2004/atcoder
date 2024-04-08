require "crystal/st"

n,m = gets.to_s.split.map(&.to_i64)
h = (0...n).map(&.hash)
st = n.to_st_xor
a = Array.new(n){ gets.to_s.split.map(&.to_i64) }

m.times do |i|
  b = a.map(&.[i]).zip(0..).group_by(&.[0])
  b.values.each do |arr|
    ix = arr.map(&.last)
    pp h.values_at(*ix)
  end
end
