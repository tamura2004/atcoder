require "crystal/indexable"

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
c = a.cs
b = c.zip(0..).map { |i, j| i - j }
cnt = b.tally.values

ans = 0_i64
cnt.each do |x|
  ans += x * (x - 1) // 2
end

pp! a
pp! c
pp! b
pp! cnt
pp ans

(0..n).each do |lo|
  (lo..n).each do |hi|
    if a[lo..hi].sum % k == (lo..hi).size
      pp! [lo,hi,a[lo..hi].sum]
    end
  end
end
