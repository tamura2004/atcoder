# uvパスのコストは根をr,lcaをpとして|uv|=|ru|+|rv|-2|rp|と
# 根からの距離に帰結できる。ここでXOR演算では2X=0であることを
# 思い出すと、|uv|=|ru|+|rv|、すなわち
# X = 0のとき：根からのXORコストが同じ頂点の組
# X != 0の時、根からのコストがYの頂点について、X^Yとの組

require "crystal/graph"

n, x = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
(n-1).times do
  g.read
end

costs = Array.new(n, 0)
dfs = uninitialized (Int32, Int32) -> Nil
dfs = -> (v : Int32, pv : Int32) do
  g.each_with_cost(v) do |nv, cost|
    next if nv == pv
    costs[nv] = costs[v] ^ cost
    dfs.call(nv, v)
  end
end
dfs.call(0, -1)

# pp! costs

cnt = costs.tally
ans = 0_i64

if x.zero?
  cnt.each do |z, c|
    ans += c.to_i64 * (c - 1) // 2
  end
else
  cnt.each do |z, c|
    if cnt.has_key?(z ^ x)
      ans += c.to_i64 * cnt[z ^ x]
    end
  end
  ans //= 2
end

pp ans

