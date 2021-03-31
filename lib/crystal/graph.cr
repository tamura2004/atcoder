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

  # fromからtoに辺を追加する
  #
  # origin : 0-indexed or 1-indexed
  # both : 無向グラフ、有向グラフ
  def add(
    from : Int32,
    to : Int32,
    origin : Int32 = 0,
    both : Bool = false
  )
    i = from - origin
    j = to - origin
    g[i] << j
    g[j] << i if both
  end

  # 辺の集合edgesを追加する
  #
  # ```
  # add [[0,1],[1,2]]
  # ```
  def add(
    edges : Array(Array(Int32)),
    origin : Int32 = 0,
    both : Bool = false
  )
    edges.each do |(from, to)|
      add(from, to, origin, both)
    end
  end

  # 文字列から辺を追加する
  def add(
    edges : String,
    origin : Int32 = 1,
    both : Bool = false
  )
    edges.split(/[|;\n]/).each do |edge|
      from, to = edge.split.map(&.to_i)
      add(from, to, origin, both)
    end
  end

  # 2部グラフ判定
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
