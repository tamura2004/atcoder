# a ** 5 < a ** 2 + b + c ** 2 < nより
# a < n ** (12/5) < 10 ** 3

MAXI = 288676_i64

require "crystal/prime"
require "crystal/segment_tree"
require "crystal/math"

n = gets.to_s.to_i64

ps = Prime.take_while(&.<= MAXI)
st = (MAXI+1).to_st_sum
ps.each { |i| st[i] = 1_i64 }

ans = 0_i64
ps.each_with_index do |a, i|
  break unless a ** 5 < n
  ps[i+1..].each do |b|
    break unless b ** 3 < n // a ** 2
    maxi = Math.isqrt(n // b // a // a)
    ans += st[b+1..maxi]
  end
end

pp ans

