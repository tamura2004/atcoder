require "spec"
require "crystal/graph/matrix_graph"
require "crystal/graph/warshall_floyd"

describe WarshallFloyd do
  it "usage" do
    g = MatrixGraph.new(3)
    g.add 1, 2, 10_i64
    g.add 2, 3, 10_i64
    WarshallFloyd.new(g).solve
    g[0,2].should eq 20
  end
end
