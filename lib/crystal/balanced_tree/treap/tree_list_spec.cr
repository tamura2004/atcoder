require "spec"
require "crystal/balanced_tree/treap/tree_list"
include BalancedTree::Treap

describe BalancedTree::Treap::TreeList do
  it "range sum" do
    t = TreeList.new(-> (x : Int32, y : Int32) { x + y})
    [6,5,4,3,2,1].each{|v| t << v }
    t.size.should eq 6
    t.acc.should eq 21
    t.acc_lower(2).should eq 11
    t.acc_upper(2).should eq 3
    t.acc.should eq 21
  end

  it "usage" do
    t = TreeList{1, 5, 2, 4, 3}
    t.values.should eq [1, 5, 2, 4, 3]
  end

  it "initialized" do
    t = TreeList(Int128).new
    t << 10_000_i128
    t << 10_000_i128
    t << 10_000_i128
  end

  it "at" do
    t = TreeList{1, 5, 2, 4, 3}
    t.at(1).should eq 5
    t.at(11).should eq nil

    t[11]?.should eq nil
    expect_raises(IndexError) { t[11] }
  end

  it "put" do
    t = TreeList{1, 5, 2, 4, 3}
    t[1] = 4
    t[3] = 5
    t.values.should eq [1, 4, 2, 5, 3]
  end

  it "rotate" do
    t = TreeList{1, 2, 3, 4, 5, 6, 7, 8, 9}
    t.rotate(2, 4, 6)
    t.values.should eq [1, 2, 5, 6, 3, 4, 7, 8, 9]
  end

  it "rotate range" do
    t = TreeList{1, 2, 3, 4, 5, 6, 7, 8, 9}
    t.rotate(2...5, -1)
    t.values.should eq [1, 2, 5, 3, 4, 6, 7, 8, 9]
  end

  it "swap" do
    t = TreeList{1, 2, 3, 4, 5}
    t.swap 0, -1
    t.values.should eq [5, 2, 3, 4, 1]
    t.swap -2, 1
    t.values.should eq [5, 4, 3, 2, 1]
  end
end
