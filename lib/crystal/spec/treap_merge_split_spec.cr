require "spec"
require "../treap_merge_split"

describe Treap do
  it "init tree" do
    tree = Treap(Tuple(Int32,Int32)).new
    tree.class.should eq Treap(Tuple(Int32,Int32))
  end

  it "init node" do
    node = Treap::Node(Int32).new(10, 100)
  end

  it "merge nil + nil" do
    left = Treap(Int32).new
    right = Treap(Int32).new
    left.merge(right)
  end

  it "merge 1 + nil" do
    node = Treap::Node(Int32).new(1,1)
    left = Treap(Int32).new(node)
    right = Treap(Int32).new
    left.merge(right)
  end

  it "merge 1 + 2" do
    left_node = Treap::Node(Int32).new(1,10)
    left = Treap(Int32).new(left_node)
    right_node = Treap::Node(Int32).new(2,2)
    right = Treap(Int32).new(right_node)
    left.merge(right)
    left.upper(1).should eq 1
    left.upper(1, eq = false).should eq 2
    left.lower(1).should eq 1
    left.lower(2).should eq 2
    left.lower(2, eq = false).should eq 1
  end

  it "insert" do
    tree = Treap(Int32).new
    tree.insert(1,100)
  end

  it "delete" do
    tree = Treap(Int32).new
    tree.insert(1,100)
    left, right = tree.split(1)
    tree.delete(1)
    tree.root.should eq nil
  end

  it "split" do
    t = Treap{1,3,5,7,9}
    t.shift.should eq 1
    pp t.to_a
    # t.shift.should eq 3
    # left, right = t.split(5)
    # left.try(&.val).should eq 5
    # right.val.should eq 7
  end
end
