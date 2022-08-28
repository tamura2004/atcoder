require "crystal/graph/i_graph"

# グラフの入次数（無向グラフの次数）
class InDeg
  getter g : IGraph
  delegate n, to: g
  
  def initialize(@g)
  end

  def solve
    Array.new(n, 0).tap do |deg|
      g.each do |v|
        g.each(v) do |nv|
          deg[nv] += 1
        end
      end
    end
  end
end
