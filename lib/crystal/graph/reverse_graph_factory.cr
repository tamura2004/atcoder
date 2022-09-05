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
        g.each_with_cost(v) do |nv, cost|
          rg.add nv, v, cost, origin: 0, both: false
        end
      end
    end
  end
end
