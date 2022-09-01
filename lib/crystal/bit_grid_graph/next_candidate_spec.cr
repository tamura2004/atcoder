require "spec"
require "crystal/bit_grid_graph/next_candidate"
include BitGridGraph

describe BitGridGraph::NextCandidate do
  it "usage" do
    g = Graph.new([
      "10",
      "00",
    ])

    c1 = Graph.new([
      "11",
      "00",
    ])

    c2 = Graph.new([
      "10",
      "10",
    ])

    ans = [] of Graph
    NextCandidate.new(g).solve do |v|
      ans << v
    end

    ans.should eq [c1,c2]
  end
end
