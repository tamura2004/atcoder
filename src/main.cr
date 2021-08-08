require "crystal/rolling_hash"

n = gets.to_s.to_i64
s = gets.to_s
rh = RollingHash.new(s)

n.times do |k|
  ans = n.times.sum do |i|
    rh.lcp(k,i)
  end

  pp ans
end
