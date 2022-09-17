require "crystal/multiset"

n, m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64).to_multiset
b = gets.to_s.split.map(&.to_i64)

ans = Int64::MAX
b.each do |y|
  if lo = a.lower(y, eq: true)
    chmin ans, (y - lo).abs
  end

  if hi = a.upper(y, eq: true)
    chmin ans, (y - hi).abs
  end
end
pp ans