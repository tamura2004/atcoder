module AbstructGraph
  class Graph(V, E)
    getter g : Hash(V, Array(E))

    def initialize
      @g = Hash(V, Array(E)).new { |h, k| h[k] = [] of E }
    end

    def add(v : V, e : E)
      g[v] << e
    end

    delegate "[]", to: g
  end
end
