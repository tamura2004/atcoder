require "spec"
require "crystal/graph/ord"
require "crystal/graph/graph"

describe Ord do
 it "usage" do
  g = Graph.new(6)
  g.add 1, 4, origin: 0, both: false
  g.add 5, 2, origin: 0, both: false
  g.add 3, 0, origin: 0, both: false
  g.add 5, 5, origin: 0, both: false
  g.add 4, 1, origin: 0, both: false
  g.add 0, 3, origin: 0, both: false
  g.add 4, 2, origin: 0, both: false
  # g.debug(0)
  Ord.new(g).solve.should eq [3,0,2,4,1,5]
 end
end
