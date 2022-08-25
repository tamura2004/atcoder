require "crystal/graph"
require "crystal/graph/ord"
require "crystal/graph/reverse_graph"

# 強連結成分分解
#
# ```
# g = Graph.new(4)
# g.add 4, 3, both: false
# g.add 3, 2, both: false
# g.add 2, 1, both: false
# g.add 1, 2, both: false
# cg, vs, ix = SCC.new(g).solve
# cg # => #<Graph:0x7f97498409e0 @g=[[1], [2], []], @n=3>
# vs # => [Set{3}, Set{2}, Set{0, 1}]
# ix.should eq [2, 2, 1, 0]
# ```
struct SCC
  alias CG = Graph             # 連結成分のグラフ
  alias CS = Array(Set(Int32)) # 連結成分の頂点集合
  alias IX = Array(Int32)      # 頂点の属する連結成分の番号

  getter g : Graph
  getter rg : Graph
  delegate n, to: g
  getter ix : IX

  def initialize(@g)
    @ix = Array.new(n, -1)
    @rg = ReverseGraph.new(g).solve
  end

  def solve : Tuple(CG, CS, IX)
    ord = Ord.new(g).solve.reverse
    k = 0
    ord.each do |v|
      next if ix[v] != -1
      dfs(v, k)
      k += 1
    end

    cg = ComponentGraph.new(g, ix).solve
    cs = ComponentSet.new(ix).solve

    {cg, cs, ix}
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

    def solve : CS
      cs = Array.new(ix.max + 1) { Set(Int32).new }
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

    def solve : CG
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
