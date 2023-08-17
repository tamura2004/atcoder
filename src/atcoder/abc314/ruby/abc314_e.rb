Roulette = Struct.new(:c, :p, :z, :s)
n, m = gets.split.map(&:to_i)
memo = Array.new(m, nil)
roulettes = Array.new(n) do
  c, p, *s = gets.split.map(&:to_i)
  z = s.count(&:zero?)
  s = s.select { _1 != 0 }
  Roulette.new(c, p, z, s)
end

dfs = ->(x) do
  return 0.0 if x >= m
  return memo[x] unless memo[x].nil?

  ans = roulettes.map do |r|
    (r.s.sum { dfs[x + _1] } + r.p * r.c) / (r.p - r.z)
  end.min

  memo[x] = ans
  ans
end

pp dfs[0]
