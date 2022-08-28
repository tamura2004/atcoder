require "crystal/graph/i_graph"

# グラフの出次数（無向グラフの次数）
class Deg
  getter g : IGraph
  delegate n, to: g
  
  def initialize(@g)
  end

  def solve
    Array.new(n, 0).tap do |deg|
      g.each do |v|
        g.each(v) do |_|
          deg[v] += 1
        end
      end
    end
  end
end
