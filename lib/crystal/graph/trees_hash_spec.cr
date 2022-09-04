require "spec"
require "crystal/graph"
require "crystal/graph/trees_hash"

def to_tree(a)
  g = Graph.new(a.size + 1)
  a.zip(0..).each do |v, nv|
    g.add v, nv + 1, origin: 0
  end
  g
end

describe TreesHash do
  it "usage" do
    g1 = to_tree([0,0,2])
    g2 = to_tree([0,1,0])
    g3 = to_tree([0,0,0])

    h1 = TreesHash.new(g1).solve
    h2 = TreesHash.new(g2).solve
    h3 = TreesHash.new(g3).solve

    h1.should eq h2
    h1.should_not eq h3

  end
end
