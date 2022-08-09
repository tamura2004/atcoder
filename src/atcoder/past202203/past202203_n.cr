require "crystal/bitset"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).sort.uniq
dp = Bitset.new(200_000)
dp.set(0)

a.each_cons_pair do |i,j|
  pp [i,j,j-i]
  dp.shift_or!(j - i)
  pp dp.to_s[-10,10]
end

ans = dp.popcount * 2 - 1
pp ans

# ans = [] of Int64
# n.times do |i|
#   n.times do |j|
#     ans << a[i] - a[j]
#   end
# end

# pp ans.uniq.sort
