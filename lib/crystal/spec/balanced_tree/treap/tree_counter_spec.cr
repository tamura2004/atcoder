require "spec"
require "crystal/balanced_tree/treap/tree_counter"
include BalancedTree::Treap

alias Tree = TreeCounter(Counter(Int32))

describe BalancedTree::Treap::TreeCounter do
  it "usage" do
    t = Tree.new
    t[1].should eq 0_i64
  end
end
