require "crystal/bitset"

n = gets.to_s.to_i64
s = Array.new(n) { gets.to_s }
a = s.map(&.chars.map(&.to_i64))
b = s.map(&.to_bitset)

ans = (0...n).sum do |i|
  (i+1...n).sum do |j|
    (b[i] & b[j]).popcount * a[i][j]
  end
end

pp ans // 3
