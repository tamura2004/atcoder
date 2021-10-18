require "spec"
require "crystal/weighted_tree/dag"
include WeightedTree

describe WeightedTree::Dag do
  it "usage" do
    g = Tree.new(4)
    g.add 1, 2, 10
    g.add 1, 3, 20
    g.add 3, 4, 30
    dag = Dag.new(g).solve
    dag.debug
    dag.g.should eq [
      [{1, 10}, {2, 20}],
      [] of Int32,
      [{3, 30}],
      [] of Int32,
    ]
  end
end
