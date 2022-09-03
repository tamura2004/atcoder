require "spec"
require "crystal/graph"
require "crystal/graph/trees_hash"

def to_tree(a)
  g = Graph.new(a.size + 1)
  a.zip(0..).each do |v, nv|
    g.add v, nv, origin: 0
  end
  g
end

describe TreesHash do
  it "usage" do
    g = Graph.new(7)
    g.add 1,2
    g.add 1,3
    g.add 2,4
    g.add 2,5
    g.add 2,6
    g.add 2,7
    h = TreesHash.new(g).solve
    # g2 = TreesHash.new(to_tree([0,1,1,0,4,4])).solve
    # g3 = TreesHash.new(to_tree([0,0,2,2,2,2])).solve

    # g1.should eq g3
    # g1.should_not eq g2

  end
end
