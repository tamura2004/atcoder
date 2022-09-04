require "crystal/graph/i_matrix_graph"

class WarshallFloyd
  getter g : IMatrixGraph
  delegate n, to: g

  def initialize(@g)
  end

  def solve
    g.each do |k|
      g.each do |i|
        g.each do |j|
          g[i, j] = Math.min g[i, j], g[i, k] + g[k, j]
        end
      end
    end
  end
end
