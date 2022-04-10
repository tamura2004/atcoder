require "spec"
require "crystal/matrix_graph/clique"
include MatrixGraph

describe MatrixGraph::Clique do
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 1
    g.add 3, 4
    cl = Clique.new(g)
    cl.solve(0b0001).should eq true
    cl.solve(0b0100).should eq true
    cl.solve(0b0111).should eq true
    cl.solve(0b1111).should eq false
  end
end
