require "crystal/graph"

# 連結成分毎の頂点数と辺数を集計
struct ConnectedDecomposition
  getter g : Graph
  delegate n, to: g
  getter gs : Array(Int32)

  def initialize(@g)
    @gs = Array.new(n, -1)
  end

  def solve
    ix = 0
    n.times do |v|
      next if gs[v] != -1
      dfs(v,ix)
      ix += 1
    end

    vs = Array.new(ix, 0)
    es = Array.new(ix, 0)
    gs.each_with_index do |i,v|
      vs[i] += 1
      es[i] += g[v].size
    end
    es.map!(&.// 2)
    { vs, es }
  end

  def dfs(v,ix)
    gs[v] = ix
    g[v].each do |nv|
      next if gs[nv] != -1
      dfs(nv,ix)
    end
  end
end

alias CD = ConnectedDecomposition