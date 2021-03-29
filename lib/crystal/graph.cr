# 重みなしグラフ
class Graph
  getter n : Int32
  getter g : Array(Array(Int32))
  delegate "[]", to: g

  def initialize(@n, @g)
  end

  def initialize(@n)
    @g = Array.new(n) { [] of Int32 }
  end

  def add_edge(
    from : Int32,
    to : Int32,
    origin : Int32 = 0,
    both : Bool = true
  )
    i = from - origin
    j = to - origin
    g[i] << j
    g[j] << i if both
  end

  def add_edge(
    edges : Array(Array(Int32)),
    origin : Int32 = 0,
    both : Bool = true
  )
    edges.each do |(from, to)|
      add_edge(from, to, origin, both)
    end
  end

  def add_edge(
    edges : String,
    origin : Int32 = 0,
    both : Bool = true
  )
    edges.split(/[;\n]/).each do |edge|
      from, to = edge.split.map(&.to_i)
      add_edge(from, to, origin, both)
    end
  end

  def is_bipartite?
    color = Array.new(n, -1)
    n.times do |i|
      next if color[i] != -1
      color[i] = 0
      q = Deque.new([i])
      while q.size > 0
        v = q.shift
        g[v].each do |nv|
          return false if color[v] == color[nv]
          next if color[nv] != -1
          color[nv] = 1 - color[v]
          q << nv
        end
      end
    end
    return true
  end
end

# Graph
# def add_edge(e : E)
# end
# MatrixGraph < Matrix
# BitGraph

# 辺の型を気にするのはGraph型だけ

# 双方向かどうか＝＞辺の追加メソッドで使い分け
# include Connectable(E)
# def add_edge(e : E)
#   g
# end

# g = Graph.new(n)
# g.add_edge(n, STDIN)
