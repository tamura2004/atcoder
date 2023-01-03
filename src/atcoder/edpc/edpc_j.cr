n = gets.to_s.to_i
memo = make_array(-1_f64, n + 1, n + 1, n + 1)
memo[0][0][0] = 0.0_f64

dfs = uninitialized (Int32, Int32, Int32) -> Float64
dfs = ->(i : Int32, j : Int32, k : Int32) do
  if memo[i][j][k] != -1_f64
    return memo[i][j][k]
  end
  ans = n.to_f64
  ans += dfs.call(i - 1, j, k) * i if i > 0
  ans += dfs.call(i + 1, j - 1, k) * j if j > 0
  ans += dfs.call(i, j + 1, k - 1) * k if k > 0
  ans /= i + j + k
  memo[i][j][k] = ans
  ans
end

a = gets.to_s.split.map(&.to_i)
i, j, k = (1..3).map { |i| a.tally[i]? || 0 }
ans = dfs.call(i, j, k)
pp ans
