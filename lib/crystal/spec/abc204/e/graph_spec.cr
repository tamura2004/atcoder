require "spec"
require "crystal/abc204/e/graph"
include Abc204::E

describe Abc204::E::Graph do
  it "usage" do
    g = Graph.new(4)
    g.add 1,2,100,100
    g.add 1,3,100,100
    g.add 3,4,100,100
    g.debug
  end
end
