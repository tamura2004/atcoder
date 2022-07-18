require "crystal/tree"
require "crystal/balanced_tree/treap/multiset"

n = gets.to_s.to_i64
c = gets.to_s.split.map(&.to_i64)
g = Tree.new(n)

(n - 1).times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

Problem.new(g, c).solve

class Problem
  getter g : Tree
  delegate n, to: g
  getter dp : Multiset(Int64)
  getter ans : Array(Bool)
  getter c : Array(Int64)

  def initialize(@g, @c)
    @dp = Multiset(Int64).new
    @ans = Array.new(n, false)
  end

  def solve(root = 0)
    dfs(root, -1)

    n.times do |v|
      puts v + 1 if ans[v]
    end
  end

  def dfs(v, pv)
    ans[v] = true unless dp.includes?(c[v])
    dp << c[v]

    g[v].each do |nv|
      next if nv == pv
      dfs(nv, v)
    end

    dp.delete(c[v])
  end
end
