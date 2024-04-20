# メモ化再帰
n, a, x, y = gets.to_s.split.map(&.to_i64)
yy = y * 6 / 5

memo = {} of Int64 => Float64
memo[0_i64] = 0.0

dp = uninitialized Proc(Int64, Float64)
dp = -> (n : Int64) do
  return memo[n] if memo.has_key?(n)
  one = x + dp.call(n // a)
  two = (2_i64..6_i64).sum do |i|
    dp.call(n // i) / 5
  end + yy
  memo[n] = Math.min(one, two)
end

ans = dp.call(n)
pp ans
