require "crystal/orderedset"

n,k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
ans = [] of Int64
os = OrderedSet(Int64).new
os << 0_i64

(k+1).times do
  v = os.shift
  ans << v
  n.times do |i|
    os << (v + a[i])
  end
end

pp ans[-1]
