require "crystal/graph/i_graph"
require "crystal/graph/ord"
require "crystal/graph/reverse_graph_factory"

class SCC
  getter g : IGraph
  delegate n, to: g

  getter now_ord : Int32
  getter group_num : Int32

  getter ord : Array(Int32)
  getter low : Array(Int32)
  getter ids : Array(Int32)
  getter visited : Array(Int32)

  def initialize(@g)
    @now_ord = 0
    @group_num = 0

    @ord = Array.new(n, -1)
    @low = Array.new(n, 0)
    @ids = Array.new(n, 0)
    @visited = [] of Int32
  end

  def solve
    g.each do |v|
      next if ord[v] != -1
      dfs(v)
    end
    ids.map!(&.-.pred.+ group_num)

    scc = Array.new(group_num) { [] of Int32 }
    g.each do |v|
      scc[ids[v]] << v
    end
    scc
  end

  def dfs(v)
    low[v] = ord[v] = now_ord
    @now_ord += 1
    visited << v

    g.each(v) do |nv|
      if ord[nv] == -1
        dfs(nv)
        low[v] = low[nv] if low[v] > low[nv]
      else
        low[v] = ord[nv] if low[v] > ord[nv]
      end
    end

    if low[v] == ord[v]
      loop do
        nv = visited.pop
        ord[nv] = n
        ids[nv] = group_num
        break if v == nv
      end

      @group_num += 1
    end
  end
end



  

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
# struct SCC
#   alias CG = IGraph             # 連結成分のグラフ
#   alias CS = Array(Set(Int32)) # 連結成分の頂点集合
#   alias IX = Array(Int32)      # 頂点の属する連結成分の番号

#   getter g : IGraph
#   getter rg : IGraph
#   delegate n, to: g
#   getter ix : IX

#   def initialize(@g)
#     @ix = Array.new(n, -1)
#     @rg = ReverseGraphFactory.new(g).solve
#   end

#   def solve : Tuple(CG, CS, IX)
#     ord = Ord.new(g).solve.reverse
#     k = 0
#     ord.each do |v|
#       next if ix[v] != -1
#       dfs(v, k)
#       k += 1
#     end

#     cg = ComponentGraph.new(g, ix).solve
#     cs = ComponentSet.new(ix).solve

#     {cg, cs, ix}
#   end

#   def dfs(v, k)
#     return if ix[v] != -1
#     ix[v] = k

#     rg.each(v) do |nv|
#       dfs(nv, k)
#     end
#   end

#   # 連結成分毎の頂点集合
#   struct ComponentSet
#     getter ix : Array(Int32)

#     def initialize(@ix)
#     end

#     def solve : CS
#       cs = Array.new(ix.max + 1) { Set(Int32).new }
#       ix.each_with_index do |v, i|
#         cs[v] << i
#       end
#       return cs
#     end
#   end

#   # 連結成分のグラフ
#   struct ComponentGraph
#     getter g : IGraph
#     getter ix : Array(Int32)
#     delegate n, to: g

#     def initialize(@g, @ix)
#     end

#     def solve : CG
#       cn = ix.max + 1
#       cg = Graph.new(cn)

#       n.times do |v|
#         g.each(v) do |nv|
#           iv, inv = ix[v], ix[nv]
#           next if iv == inv
#           cg.add iv, inv, origin: 0, both: false
#         end
#       end

#       cn.times do |v|
#         cg[v].uniq!
#       end

#       return cg
#     end
#   end
# end
