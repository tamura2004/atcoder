require "spec"
require "crystal/balanced_tree/treap/xorshift"
include BalancedTree::Treap

describe BalancedTree::Treap::Xorshift do
  it "usage" do
    one = Xorshift.get
    two = Xorshift.get
    one.should_not eq two
  end
end
