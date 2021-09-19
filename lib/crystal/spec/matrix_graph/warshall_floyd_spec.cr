require "spec"
require "crystal/matrix_graph/warshall_floyd"
include MatrixGraph

describe MatrixGraph::WarshallFloyd do
  it "usage" do
    g = Graph.new(3)
    g.add 1,2,1
    g.add 2,3,2
    WarshallFloyd.new(g).solve
    g[0][2].should eq 3
  end
end
