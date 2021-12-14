require "crystal/indexable"
require "crystal/fenwick_tree"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i).compress(1)
b = gets.to_s.split.map(&.to_i).compress(1)

cnt = Hash(Tuple(Int32, Int32), Int64).new(0_i64)
a.zip(b).each do |a, b|
  cnt[{a, b}] += 1
end

ab = a.zip(b).uniq.sort_by { |a, b| {a, -b} }
bit = BIT.new(n)

ans = 0_i64
ab.each do |a, b|
  i = cnt[{a, b}]
  bit[b] = i
  ans += i * bit[b..]
end

pp ans
