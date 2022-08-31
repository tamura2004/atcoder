require "crystal/graph"
require "crystal/graph/i_graph"

struct ReverseGraphFactory
  getter g : IGraph
  delegate n, to: g

  def initialize(@g)
    raise "有向グラフではありません" if g.both
  end

  def solve
    Graph.new(n).tap do |rg|
      g.each do |v|
        g.each(v) do |nv|
          rg.add nv, v, origin: 0, both: false
        end
      end
    end
  end
end
