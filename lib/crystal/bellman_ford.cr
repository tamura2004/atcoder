class Graph
  record Edge, from : Int32, to : Int32, cost : Int64
  getter n : Int32
  getter g : Array(Array(Edge))

  def initialize(@n)
    @g = Array.new(n){ [] of Edge }
  end

  def add(from, to, cost)
    @g[from] << Edge.new(from, to, cost.to_i64)
  end
end

class BellmanFord < Graph
  INF = Int64::MAX
  getter d : Array(Int64)
  getter neg : Array(Bool)

  def initialize(@n)
    super
    @d = Array.new(n, INF)
    @neg = Array.new(n, false)
  end

  # ベルマンフォード法による最短経路
  def solve(start) : Tuple(Array(Int64),Array(Bool))
    @d[start] = 0_i64
    n.times do |i|
      g.each do |v|
        v.each do |e|
          if d[e.from] != INF && d[e.to] > d[e.from] + e.cost
            d[e.to] = d[e.from] + e.cost
            # n回目で更新されるなら負閉路
            if i == n - 1
              neg[e.to] = true
            end
          end
        end
      end
    end
    
    # 負閉路から到達できる点
    n.times do |i|
      g.each do |v|
        v.each do |e|
          neg[e.to] = true if neg[e.from]
        end
      end
    end

    return {d, neg}
  end
end