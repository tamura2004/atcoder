module WeightedFlowGraph
  record Edge, to : Int32, cap : Int64, cost : Int64, rev : Int32 do
    def [](i)
      {to, cap, cost, rev}[i]
    end

    def +(d)
      Edge.new to, cap + d, cost, rev
    end

    def -(d)
      Edge.new to, cap - d, cost, rev
    end
  end

  class Graph
    getter n : Int32
    getter g : Array(Array(Edge))
    delegate "[]", to: g

    def initialize(n)
      @n = n.to_i
      @g = Array.new(n) { [] of Edge }
    end

    def add(from, to, cap, cost, origin = 1)
      from = from.to_i - origin
      to = to.to_i - origin
      cap = cap.to_i64
      cost = cost.to_i64

      g[from] << Edge.new(to, cap, cost, g[to].size)
      g[to] << Edge.new(from, 0_i64, -cost, g[from].size - 1)
    end
  end
end
