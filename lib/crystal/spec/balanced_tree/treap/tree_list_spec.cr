require "spec"
require "crystal/balanced_tree/treap/tree_list"
include BalancedTree::Treap

describe BalancedTree::Treap::TreeList do
  it "usage" do
    t = TreeList{1,5,2,4,3}
    t.to_a.should eq [1,5,2,4,3]
  end
  
  it "fetch" do
    t = TreeList{1,5,2,4,3}
    t.fetch(1).should eq 5
    t.fetch(11).should eq nil
  end
  
  it "put" do
    t = TreeList{1,5,2,4,3}
    t[1] = 4
    t[3] = 5
    t.to_a.should eq [1,4,2,5,3]
  end
end
