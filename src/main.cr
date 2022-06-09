# さて、レベルNバーガーは何層だろうか？
# f(N) = 層数とする
# f(0) = 1
# f(N+1) = f(N) * 2 + 3
# ではパティは何枚含むだろうか
# ps(N) = パティ数とする
# ps(0) = 1
# ps(N+1) = ps(N) * 2 + 1
# N <= 50なので、予め求めておくことができる
# ちなみに、レベルNバーガーの丁度真ん中のパティを食べるときの枚数
# pi(0)=1
# pi(n+1) = f(n) + 2

n, x = gets.to_s.split.map(&.to_i64)
f = [1_i64]
ps = [1_i64]
pi = [1_i64]
n.times do
  pi << f[-1] + 2
  f << f[-1] * 2 + 3
  ps << ps[-1] * 2 + 1
end

# pp! f
# pp! ps
# pp! pi

# 今、レベルnバーガーのx枚目を気にしている
# 中央のパティより右であれば、左はレベルn-1バーガーの
# パティ数をpより取れば良い。
# 右は、レベルn-1バーガーからのx'=x-pi(n)枚食べたとき
# であり、小問題に分割された。
# 丁度中央のパティを食べる場合に注意

solve = uninitialized Proc(Int64, Int64, Int64)
solve = ->(n : Int64, x : Int64) do
  # pp! [n,x]
  return ps[n] if f[n] <= x

  raise "bad negative number #{x}" if x < 0
  raise "bad negative level #{n}" if n < 0

  return 0_i64 if x == 0
  raise "bad n = #{n}, x = #{x}" if n == 0 && x > 1
  return 1_i64 if n == 0

  if x < pi[n]
    solve.call(n - 1, x - 1)
  elsif x == pi[n]
    ps[n - 1] + 1
  else
    ps[n - 1] + 1 + solve.call(n - 1, x - pi[n])
  end
end

ans = solve.call(n, x)
pp ans
