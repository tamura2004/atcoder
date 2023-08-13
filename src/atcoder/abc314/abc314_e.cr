# 期待値DP
# ポイントを状態Xとして持つ、E[X]はX>=Mの時ゼロ
# メモ化再帰を使用する

n, m = gets.to_s.split.map(&.to_i)
memo = Array.new(m, nil.as(Float64?))

lo = Array.new(n) do
  c, p, *s = gets.to_s.split.map(&.to_i64)
  z = s.count(&.zero?)
  s = s.select(&.!= 0)
  {c, p, z, s}
end

dfs = uninitialized Int32 -> Float64
dfs = ->(x : Int32) do
  return 0_f64 if x >= m
  if ans = memo[x]
    return ans
  end

  ans = lo.min_of do |c, p, z, s|
    (s.sum { |y| dfs.call(x + y) } + p * c) / (p - z)
  end
  memo[x] = ans
  return ans
end
pp dfs.call(0)
