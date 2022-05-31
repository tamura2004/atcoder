require "spec"
require "crystal/balanced_tree/treap/counter"
include BalancedTree::Treap

describe BalancedTree::Treap::Counter do
  it "usage" do
    cnt = Counter(Int32).new(7,1)
    cnt.key.should eq 7
    cnt.cnt.should eq 1
  end
end
