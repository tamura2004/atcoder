require "spec"
require "../prbst"

describe PRBST do
  it "init nil tree" do
    t = PRBST(Int32).new
    t.nil_tree?.should eq true
    t.size.should eq 0
  end

  it "init tree" do
    t = PRBST{1,2,3}
    t.nil_tree?.should eq false
    t.size.should eq 3
  end

  it "merge" do
    left = PRBST{1,2,3}
    right = PRBST{4,5,6}
    left.to_a.should eq [1,2,3]
    right.to_a.should eq [4,5,6]
    left = left.merge(right)
    left.to_a.should eq [1,2,3,4,5,6]
    right.to_a.should eq [4,5,6]
    left.class.should eq PRBST(Int32)
    right.class.should eq PRBST(Int32)
  end

  it "split" do
    tree = PRBST{1,3,5,7,9,11}
    left, right = tree.split(6)
    tree.to_a.should eq [1,3,5,7,9,11]
    left.try(&.to_a).should eq [1,3,5]
    right.try(&.to_a).should eq [7,9,11]
    left.class.should eq PRBST::Node(Int32)
    right.class.should eq PRBST::Node(Int32)
  end

  it "delete" do
    tree = PRBST{1,3,5,7,9,11}
    after = tree.delete(7)
    tree.to_a.should eq [1,3,5,7,9,11]
    after.try(&.to_a).should eq [1,3,5,9,11]
  end

  it "range split" do
    tree = PRBST{1,3,5,7,9,11}
    mid, both = tree.split(4..8)
    mid.to_a.should eq [5,7]
    both.try(&.to_a).should eq [1,3,9,11]
  end

  it "range get" do
    tree = PRBST{1,3,5,7,9,11}
    mid = tree[4..8]
    mid.to_a.should eq [5,7]
  end


end
