require "spec"
require "crystal/graph/in_degree"

describe InDegree do
  it "usage" do
    g = Graph.new(3)
    g.add 1, 2, both: false
    g.add 3, 2, both: false
    InDegree.new(g).solve.should eq [0, 2, 0]
  end
end
