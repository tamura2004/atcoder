require "crystal/xor_base"

n,l,r = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
xb = XorBase.new
a.each{|v| xb << v}
xb.sweep!
base = xb.base.sort

l = l.pred
r = r.pred

ans = [] of Int64
(l..r).each do |i|
  cnt = 0_i64
  60.times do |j|
    if i.bit(j) == 1
      cnt ^= base[j]
    end
  end
  ans << cnt
end

puts ans.join(" ")
