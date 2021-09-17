require "crystal/graph"
require "crystal/graph/ord"
require "crystal/graph/reverse_graph"

# 強連結成分分解
struct SCC
  getter g : Graph
  getter rg : Graph
  delegate n, to: g
  getter ix : Array(Int32) # 頂点が属する成分の番号

  def initialize(@g)
    @ix = Array.new(n, -1)
    @rg = ReverseGraph.new(g).solve
  end

  def solve
    ord = Ord.new(g).solve.reverse
    k = 0
    ord.each do |v|
      next if ix[v] != -1
      dfs(v, k)
      k += 1
    end

    cg = ComponentGraph.new(g, ix).solve
    cs = ComponentSet.new(ix).solve

    { cg, cs, ix }
  end

  def dfs(v, k)
    return if ix[v] != -1
    ix[v] = k

    rg[v].each do |nv|
      dfs(nv, k)
    end
  end

  # 連結成分毎の頂点集合
  struct ComponentSet
    getter ix : Array(Int32)

    def initialize(@ix)
    end

    def solve
      cs = Array.new(ix.max + 1){ Set(Int32).new }
      ix.each_with_index do |v, i|
        cs[v] << i
      end
      return cs
    end
  end

  # 連結成分のグラフ
  struct ComponentGraph
    getter g : Graph
    getter ix : Array(Int32)
    delegate n, to: g

    def initialize(@g, @ix)
    end

    def solve
      cn = ix.max + 1
      cg = Graph.new(cn)

      n.times do |v|
        g[v].each do |nv|
          iv, inv = ix[v], ix[nv]
          next if iv == inv
          cg.add iv, inv, origin: 0, both: false
        end
      end

      cn.times do |v|
        cg[v].uniq!
      end
      
      return cg
    end
  end
end
