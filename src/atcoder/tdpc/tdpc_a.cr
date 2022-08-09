require "crystal/bitset"
n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
dp = Bitset.new(10_001)
dp.set(0)
a.each do |v|
  dp.shift_or!(v)
end
pp dp.popcount
