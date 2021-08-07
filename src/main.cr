require "crystal/segment_tree"

w, n = gets.to_s.split.map(&.to_i)
lrv = Array.new(n) do
  l, r, v = gets.to_s.split.map(&.to_i64)
  {l, r, v}
end

dp = (0..n).map do |i|
  st = SegmentTree.new(values: [Int64::MIN] * (w + 1), unit: Int64::MIN) do |x, y|
    Math.max(x, y)
  end
  st[0] = 0_i64
  st
end

n.times do |i|
  l, r, v = lrv[i]

  (0..w).each do |j|
    lo = j - r
    hi = j - l

    dp[i + 1][j] = Math.max(dp[i][j], dp[i][lo..hi] + v)
  end
end

puts Math.max(dp[-1][w], -1)

