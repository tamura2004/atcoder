# Σ pi * wi / Σ wi　を最大化したい
# Σ pi * wi / Σ wi　がx以下である。として二分探索
# Σ (pi * wi) / Σ wi　<= x%
# Σ pi * wi - x * Σ wi <= 0
# Σ (pi * wi - x * wi) <= 0
# Σ ((pi - x) * wi) <= 0

n, k = gets.to_s.split.map(&.to_i)
wp = Array.new(n) do
  w, p = gets.to_s.split.map(&.to_i64)
  {w, p}
end

query = -> (x : Float64) do
  wk = wp.map do |w, p|
    (p - x) * w
  end.sort

  wk.last(k).sum <= 0
end

lo = 0.0
hi = 101.0
ans = (lo..hi).bsearch(&query)

pp ans
