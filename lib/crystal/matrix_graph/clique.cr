require "crystal/matrix_graph/graph"

# クリーク判定
# 引数sは、頂点集合のbit表現
# ```
# g = Graph.new(5)
# g.add 1, 2
# g.add 2, 3
# g.add 3, 1
# g.add 3, 4
# cl = Clique.new(g)
# cl.solve(0b0111) # => true
# cl.solve(0b1111) # => false
# ```
module MatrixGraph
  class Clique
    getter g : Graph
    delegate n, to: g

    def initialize(@g)
    end

    def solve(s)
      n.times do |v|
        next if s.bit(v).zero?
        n.times do |nv|
          next if s.bit(nv).zero?
          next unless v < nv
          return false if g[v][nv] == INF
        end
      end
      return true
    end
  end
end
