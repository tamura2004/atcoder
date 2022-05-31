require "spec"
require "crystal/balanced_tree/treap/entry"
include BalancedTree::Treap

describe BalancedTree::Treap::Entry do
  it "usage" do
    entry = Entry(Int32).new(7)
    entry.key.should eq 7
    entry.cnt.should eq 1
  end
end
