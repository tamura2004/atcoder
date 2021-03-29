# 重み付きグラフ
abstract class WeightedGraph
  getter n : Int32
  getter g : Array(Array(Tuple(Int32,Int64)))
  delegate "[]", to: g

  def initialize(@n)
    @g = Array.new(n){ [] of Tuple(Int32,Int64) }
  end

  # fromからtoに重みcostの辺を追加する
  #
  # origin : 0-indexed or 1-indexed
  # both : 無向グラフ、有向グラフ
  def add_edge(
    from : Int32,
    to : Int32,
    cost : Int64,
    origin : Int32 = 0,
    both : Bool = true
  )
    i = from - origin
    j = to - origin
    g[i] << {j, cost}
    g[j] << {i, cost}
  end

  # 辺の集合edgesを追加する
  #
  # ```
  # add_edge([{1,2,3_i64},{2,3,4_i64}])
  # ```
  def add_edge(
    edges : Array(Tuple(Int32,Int64)),
    origin : Int32 = 0,
    both : Bool = true
  )
    edges.each do |from, to, cost|
      add_edge(from, to, cost, origin, both)
    end
  end

  # 文字列から辺を追加する
  #
  # ```
  # add_edge("1 2;2 3;3 4")
  # add_edge("1 2\n2 3\n3 4")
  # ```
  def add_edge(
    edges : String,
    origin : Int32 = 0,
    both : Bool = true
  )
    edges.split(/[;\n]/).each do |edge|
      from, to, cost = edge.split.map(&.to_i)
      cost = cost.to_i64
      add_edge(from, to, cost, origin, both)
    end
  end
end
