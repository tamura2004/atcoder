require "spec"
require "crystal/balanced_tree/treap/node"
include BalancedTree::Treap

describe BalancedTree::Treap::Node do
  it "usage" do
    n = Node(Int32, Int32).new(1, 2)
    n.key.should eq 1
    n.val.should eq 2
    n.acc.should eq 2
    n.size.should eq 1
    n.left.should eq nil
    n.right.should eq nil
    n.includes?(1).should eq true
    n.includes?(2).should eq false
    n.fetch(1).should eq 2
    n.fetch(2).should eq nil
    n.at(0).should eq 2
    n.at(1).should eq nil
    n.put(0,10)
    n.fetch(1).should eq 10
    n.at(0).should eq 10
    n.to_a.should eq [1]
    n.keys.should eq [1]
    n.values.should eq [10]
  end
end
