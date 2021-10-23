require "crystal/rolling_hash"

s = gets.to_s
t = gets.to_s

n = s.size
m = t.size

if n < m
  s *= (m + n - 1) // n
end

rs = RollingHash.new(s)
ht = RollingHash.new(t)[0..]

n.times do |i|
  next if s.size < i + m
  if rs[i, m] == ht
    pp i
  end
end
