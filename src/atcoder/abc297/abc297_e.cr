require "crystal/orderedset"

n,k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
os = OrderedSet(Int64).new

(1<<10).times do |s|
  next if s.zero?
  tot = 0_i64
  n.times do |i|
    next if s.bit(i) == 0
    tot += a[i]
  end
  os << tot
end

pp os
puts os.unsafe_fetch(k-1)

