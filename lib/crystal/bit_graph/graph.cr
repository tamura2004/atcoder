module BitGraph
  # 重みなしグラフのビット集合表現
  class Graph
    getter n : Int32
    getter g : Array(Int64)
    delegate "[]", to: g

    def initialize(n)
      @n = n.to_i
      @g = Array.new(n, 0_i64)
    end

    def add(v, nv, origin = 1, both = true)
      v = v.to_i - origin
      nv = nv.to_i - origin
      g[v] |= 1_i64 << nv
      g[nv] |= 1_i64 << v if both
    end

    # デバッグ用
    def print
      puts g.map(&.to_bit(n).reverse).join("\n")
    end
  end
end
