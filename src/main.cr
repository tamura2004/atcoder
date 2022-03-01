require "crystal/complex"

n, m = gets.to_s.split.map(&.to_i64)

nc = Array.new(n) do
  x, y, r = gets.to_s.split.map(&.to_i64)
  {C.new(x, y), r}
end

mc = Array.new(m) do
  x, y = gets.to_s.split.map(&.to_i64)
  C.new(x, y)
end

m == 0 && p(nc.map(&.[1]).min) + exit

# 円の直径をxにできない（の最小値）
# あるNの円との距離が,r+x未満
# あるMの円との距離が,2x未満
q = ->(x : Float64 | Int32) {
  x = x.to_f64

  a1 = nc.product(mc).any? do |(z, r), w|
    (z - w).abs2 < (x + r) ** 2
  end

  a2 = mc.combinations(2).any? do |(z, w)|
    (z - w).abs < (x * 2) ** 2
  end

  a1 || a2
}

ans = (0..1e10).bsearch(&q)
pp ans
