# 重み付きグラフ
abstract class WeightedGraph
  getter n : Int32
  getter g : Array(Array(Tuple(Int32, Int64)))
  delegate "[]", to: g

  def initialize(@n)
    @g = Array.new(n) { [] of Tuple(Int32, Int64) }
  end

  def reverse
    r = self.class.new(n)
    n.times do |v|
      g[v].each do |nv, cost|
        r.add nv, v, cost
      end
    end
    return r
  end

  # fromからtoに重みcostの辺を追加する
  #
  # origin : 0-indexed or 1-indexed
  # both : 無向グラフ、有向グラフ
  def add(
    from : Int32,
    to : Int32,
    cost : Int64,
    origin : Int32 = 0,
    both : Bool = false
  )
    i = from - origin
    j = to - origin
    g[i] << {j, cost}
    g[j] << {i, cost} if both
  end

  # 辺の集合edgesを追加する
  #
  # ```
  # add([{1, 2, 3_i64}, {2, 3, 4_i64}])
  # ```
  def add(
    edges : Array(Tuple(Int32, Int64)),
    origin : Int32 = 0,
    both : Bool = false
  )
    edges.each do |from, to, cost|
      add(from, to, cost, origin, both)
    end
  end

  # 文字列から辺を追加する
  #
  # ```
  # add("1 2 3;2 3 4;3 4 5")
  # ```
  def add(
    edges : String,
    origin : Int32 = 1,
    both : Bool = false
  )
    edges.split(/[|;\n]/).each do |edge|
      from, to, cost = edge.split.map(&.to_i)
      cost = cost.to_i64
      add(from, to, cost, origin, both)
    end
  end
end
