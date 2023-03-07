# dp[Si直前の区切りでラウンド終了] := ラウンド数の最小値

require "crystal/segment_tree"

r, n, m, l = gets.to_s.split.map(&.to_i64)
s = gets.to_s.split.map(&.to_i64).to_st_sum

INF = Int64::MAX // 4
dp = Array.new(l + 1, INF)
dp[0] = 0_i64

l.times do |lo|
  (1..m).each do |j|
    hi = lo + j
    next if l < hi
    next if n < s[lo...hi]
    
    # 長さm未満であれば丁度nになったところ
    # 長さm未満かつ（合計nでない　または　最後がゼロ）
    # 長さmかつ合計nかつ最後がゼロ
    
    next if hi - lo < m && (s[lo...hi] < n || s[hi - 1] == 0)
    next if hi - lo == m && s[lo...hi] == n && s[hi - 1] == 0
    chmin dp[hi], dp[lo] + 1
  end
end

# pp dp
puts dp[-1] <= r ? :Yes : :No
