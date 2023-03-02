require "crystal/graph/base_graph"

alias Graph = BaseGraph(Int32)

struct Int
  def to_g
    Graph.new(self)
  end
end
