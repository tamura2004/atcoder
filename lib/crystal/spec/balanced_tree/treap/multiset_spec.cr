require "spec"
require "crystal/balanced_tree/treap/multiset"
include BalancedTree::Treap

describe BalancedTree::Treap::Multiset do
  it "usage" do
    t = Multiset{4, 5, 3, 1, 2}
    t.to_a.should eq [1, 2, 3, 4, 5]
    3.in?(t).should eq true
  end

  it "split" do
    t = Multiset{1, 2, 3, 4, 5}
    tail = t.split(3)
    t.to_a.should eq [1, 2]
    tail.to_a.should eq [3, 4, 5]
  end

  it "split_at" do
    t = Multiset{1, 2, 3, 4, 5}
    tail = t.split_at(3)
    t.to_a.should eq [1, 2, 3]
    tail.to_a.should eq [4, 5]
  end

  it "merge" do
    head = Multiset{1, 2}
    tail = Multiset{3, 4, 5}
    head.merge tail
    head.to_a.should eq [1, 2, 3, 4, 5]
  end

  it "indexable" do
    t = Multiset{1, 2, 3, 3, 4, 4, 5}
    t[2].should eq 3
    t[-1].should eq 5

    expect_raises(IndexError) do
      t[100]
    end

    t[100]?.should eq nil

    t.empty?.should eq false
  end
end
