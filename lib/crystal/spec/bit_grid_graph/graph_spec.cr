require "spec"
require "crystal/bit_grid_graph/graph"
include BitGridGraph

describe BitGridGraph::Graph do
  it "usage" do
    g = Graph.new(4,4)
    g.set 15+15*16*16*16
    g[0,1] = 0
    g[0,2] = 0
    g.debug
  end
end
