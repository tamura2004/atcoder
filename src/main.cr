require "crystal/tree"
require "crystal/tree/subtree_size"
require "crystal/mod_int"

n = gets.to_s.to_i
g = Tree.new(n)

(n-1).times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

struct Problem
  getter g : Tree
  delegate n, to: g
  getter dp : Array(ModInt)
  getter sub : Array(Int32)

  def initialize(@g)
    @dp = Array.new(n){ 1.to_m }
    @sub = SubtreeSize.new(g).solve
  end

  def solve
    ans = 0.to_m

    n.times do |v|
      dp.fill(1.to_m)
      @sub = SubtreeSize.new(g).solve(v)
      dfs(v, -1)
      ans += dp[v]
    end

    ans // 2
  end

  def dfs(v, pv)
    dp[v] = ModInt.f(sub[v] - 1)

    g[v].each do |nv|
      next if nv == pv
      dfs(nv, v)
      dp[v] *= dp[nv]
      dp[v] //= ModInt.f(sub[nv])
    end
  end
end

pp Problem.new(g).solve
