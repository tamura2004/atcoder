require "spec"
require "crystal/weighted_graph/dijkstra"

include WeightedGraph

describe Dijkstra do
  # [1] -2-> [2]
  #  | \      |
  #  7   3    2
  #  |     \  |
  #  V      v V
  # [4] <-2- [3]
  it "usage" do
    g = Graph.new(4)
    g.add 1, 2, 2
    g.add 2, 3, 2
    g.add 1, 3, 3
    g.add 3, 4, 2
    g.add 1, 4, 7
    Dijkstra.new(g).solve.should eq [0, 2, 3, 5]
  end
end
