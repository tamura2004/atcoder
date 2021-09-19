require "crystal/matrix_graph/graph"

module MatrixGraph
  class WarshallFloyd
    getter g : Graph
    delegate n, to: g

    def initialize(@g)
    end

    def solve
      n.times do |k|
        n.times do |i|
          n.times do |j|
            g[i][j] = Math.min g[i][j], g[i][k] + g[k][j]
          end
        end
      end
    end
  end
end
