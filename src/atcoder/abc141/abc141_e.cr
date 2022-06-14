# abc141e
# ローリングハッシュ利用
# 計算量 O(N^2 log N) -> O(N (log N)^2)

require "crystal/rolling_hash"
require "crystal/range"

n = gets.to_s.to_i64
s = gets.to_s
rh = RollingHash.new(s)

# 長さmの部分列について全探索 O(N) <- 単調性があるので2分探索にできるO(log N)
# (0..n//2).each do |m| <- 全探索の場合
ans = (0..n//2).reverse_bsearch do |m|

  # 最左の出現位置 O(log N)
  pre = Hash(RollingHash::ModInt, Int32 | Int64).new

  # 全てのsの先頭位置iについて全探索 O(N)
  # いずれか一つ条件を満たすものがあればよい
  (n-m+1).times.any? do |i|
    key = rh[i, m]

    if pre.has_key?(key)
      # 同じハッシュの部分列が既出であり、
      # 重ならないよう距離が離れている
      m <= i - pre[key]
    else
      pre[key] = i
      false
    end
  end
end

# `reverse_bsearch`なのでansは条件を満たす最大m
pp ans ? ans : 0
