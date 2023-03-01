require "crystal/ntt_convolution"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64).reverse

aa = a + a

tot = Array.new(n, 0_i64)
(0...5).reverse_each do |i|
  ai = aa.map{|v|v.bit(i)}
  bi = b.map{|v|v.bit(i)}
  c = convolution(ai, bi)
  n.times do |j|
    tot[j] <<= 1
    tot[j] += c[j+n-1]
  end
end

ans = a.sum + b.sum - tot.min
pp ans
