require "crystal/connectable"

class Graph(E)
  include Connectable(E)

  getter n : Int32
  getter g : Array(Array(E))

  def initialize(@n)
    @g = Array.new(n){ [] of E }
  end

  def add_edge(from, to)
    g[from] << to    
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
