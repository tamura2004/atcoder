require "spec"
require "../treap_split_merge_nilnode"

describe Treap do
  it "init treap" do
    root = Treap::RealNode(Int32).new(2, 10)
    tree = Treap(Int32).new(root)
    left = Treap::RealNode(Int32).new(1, 7)
    right = Treap::RealNode(Int32).new(3, 8)
    tree.root.left = left
    tree.root.right = right
  end

  it "nil node" do
    # Treap::NilNode(Int32).update
    Treap::RealNode(Int32).new(1,10).size.should eq 1
    Treap::RealNode(Int32).new(1,10).left.size.should eq 1
    # x.should eq 0
  end
end
