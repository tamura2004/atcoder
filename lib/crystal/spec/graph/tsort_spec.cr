require "spec"
require "crystal/graph/tsort.cr"

module Graph
  describe Tsort do
    it "usage" do
      g = Graph.new(4)
      g.add 2, 1, both: false
      g.add 3, 1, both: false
      g.add 4, 2, both: false
      g.add 4, 3, both: false
      Tsort.new(g).solve.should eq [3, 1, 2, 0]
    end
  end
end
