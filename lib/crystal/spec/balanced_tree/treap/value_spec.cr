require "spec"
require "crystal/balanced_tree/treap/value"

module BalancedTree::Treap
  describe BalancedTree::Treap::Value do
    it "initialize by value" do
      v = Value(Int32).new(7)
      v.val.should eq 7
    end
  end
end