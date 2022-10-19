require "crystal/segment_tree"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
st = a.to_st_sum

# dp[lo][hi] := [lo, hi)の答え
INF = Int64::MAX
dp = Array.new(n + 1) do |lo|
  Array.new(n + 1) do |hi|
    case hi - lo
    when 0, 1 then 0_i64
    else           INF
    end
  end
end

(0..n).each do |w|
  (0..n).each do |lo|
    hi = lo + w
    break if n < hi

    sum = st[lo...hi]
    (lo..hi).each do |m|
      next if dp[lo][m] == INF || dp[m][hi] == INF
      chmin dp[lo][hi], dp[lo][m] + dp[m][hi] + sum
    end
  end
end

pp dp[0][-1]
