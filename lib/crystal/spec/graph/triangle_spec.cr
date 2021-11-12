require "spec"
require "crystal/graph/triangle"

describe Triangle do
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2
    g.add 1, 3
    g.add 1, 4
    g.add 2, 4
    g.add 2, 5
    g.add 4, 5
    g.add 4, 3
    Triangle.new(g).solve.should eq [{0, 1, 3}, {0, 2, 3}, {1, 3, 4}]
  end
end
