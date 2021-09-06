require "spec"
require "../treap_merge_split"

describe Treap do
  it "init tree" do
    tree = Treap(Tuple(Int32, Int32)).new
    tree.size.should eq 0
    tree.class.should eq Treap(Tuple(Int32, Int32))
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
    node = Treap::Node(Int32).new(1, 1)
    left = Treap(Int32).new(node)
    right = Treap(Int32).new
    left.merge(right)
  end

  it "merge 1 + 2" do
    left_node = Treap::Node(Int32).new(1, 10)
    left = Treap(Int32).new(left_node)
    right_node = Treap::Node(Int32).new(2, 2)
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
    tree.insert(1, 100)
  end

  it "delete" do
    tree = Treap(Int32).new
    tree.insert(1, 100)
    left, right = tree.split(1)
    tree.delete(1)
    tree.root.should eq nil
  end

  it "min max" do
    t = Treap{1, 3, 5, 7, 9}
    t.size.should eq 5
    t.min.should eq 1
    t.max.should eq 9
    ans = [] of Int32
    t.each do |v|
      ans << v
    end
    ans.should eq [1, 3, 5, 7, 9]
  end

  it "split" do
    t = Treap{2, 3, 5, 7, 11, 13, 17}
    fst, snd = t.split(7, eq = false)
    fst.try(&.to_a).should eq [2, 3, 5]
    snd.try(&.to_a).should eq [7, 11, 13, 17]
  end

  it "split at" do
    t = Treap{2, 3, 5, 7, 11, 13, 17}
    fst, snd = t.split_at(4)
    fst.try(&.to_a).should eq [2, 3, 5, 7]
    snd.try(&.to_a).should eq [11, 13, 17]
  end

  it "delete" do
    t = Treap{2,3,3,3,3,5}
    t.delete(3).try(&.to_a).should eq [2,3,3,3,5]
  end

  it "shift" do
    t = Treap{2,3,3,5}
    t.shift.should eq 2
    t.shift.should eq 3
    t.shift.should eq 3
    t.shift.should eq 5
    t.shift.should eq nil
  end

  it "pop" do
    t = Treap{2,3,3,5}
    t.pop.should eq 5
    t.pop.should eq 3
    t.pop.should eq 3
    t.pop.should eq 2
    t.pop.should eq nil
  end
end
