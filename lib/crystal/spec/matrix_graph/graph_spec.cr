require "spec"
require "crystal/matrix_graph/graph"
include MatrixGraph

describe MatrixGraph::Graph do
  it "usage" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 4
  end
end
