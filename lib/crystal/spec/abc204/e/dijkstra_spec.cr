require "spec"
require "crystal/abc204/e/dijkstra"
include Abc204::E

describe Abc204::E::Dijkstra do
  it "usage" do
    g = Graph.new(2)
    g.add 1,2,2,3
    pp Dijkstra.new(g).solve
  end
end
