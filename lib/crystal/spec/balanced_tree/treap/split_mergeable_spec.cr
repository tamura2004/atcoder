require "spec"
require "crystal/balanced_tree/treap/multiset"
require "crystal/balanced_tree/treap/split_mergeable"
include BalancedTree::Treap

describe BalancedTree::Treap::SplitMergeable do
  it "+ as merge alias" do
    head = Multiset{1, 2}
    tail = Multiset{3, 4, 5}
    head + tail
    head.to_a.should eq [1, 2, 3, 4, 5]
  end

  it "| as split alias" do
    t = Multiset{1, 2, 3, 4, 5}
    tail = t | 3
    t.to_a.should eq [1, 2]
    tail.to_a.should eq [3, 4, 5]
  end  

  it "^ as split_at alias" do
    t = Multiset{1, 2, 3, 4, 5}
    tail = t ^ 3
    t.to_a.should eq [1, 2, 3]
    tail.to_a.should eq [4, 5]
  end  

  it "insert" do
    t = Multiset{1}
    t.insert(2)
    t.to_a.should eq [1,2]
  end
  
  it "<< as insert alias" do
    t = Multiset{1}
    t << 2
    t.to_a.should eq [1,2]
  end

  it "delete" do
    t = Multiset{1, 2, 2, 3}
    t.delete 2
    t.to_a.should eq [1, 2, 3]
  end

  it "delete_all" do
    t = Multiset{1, 2, 2, 3}
    t.delete_all 2
    t.to_a.should eq [1, 3]
  end

  it "shift" do
    t = Multiset{1, 1, 2, 3}
    k = t.shift
    t.to_a.should eq [1, 2, 3]
    k.should eq 1
  end

  it "pop" do
    t = Multiset{1, 1, 2, 3}
    k = t.pop
    t.to_a.should eq [1, 1, 2]
    k.should eq 3
  end

  it "first" do
    t = Multiset{1,2}
    t.first.should eq 1
    t.delete 1
    t.delete 2
    t.first.should eq nil
  end

  it "last" do
    t = Multiset{1,2}
    t.last.should eq 2
    t.delete 1
    t.delete 2
    t.last.should eq nil
  end

  it "upper" do
    t = Multiset{1, 10, 100, 1000}
    t.upper(33).should eq 100
    t.upper(1000).should eq 1000
    t.upper(2000).should eq nil
  end

  it "upper not equal" do
    t = Multiset{1, 10, 100, 1000}
    t.upper(33, eq: false).should eq 100
    t.upper(100, eq: false).should eq 1000
    t.upper(1000, eq: false).should eq nil
  end

  it "lower" do
    t = Multiset{1, 10, 100, 1000}
    t.lower(0).should eq nil
    t.lower(33).should eq 10
    t.lower(1000).should eq 100
    t.lower(2000).should eq 1000
  end

  it "lower equal" do
    t = Multiset{1, 10, 100, 1000}
    t.lower(0, eq: true).should eq nil
    t.lower(33, eq: true).should eq 10
    t.lower(1000, eq: true).should eq 1000
    t.lower(2000, eq: true).should eq 1000
  end

  it "lower and upper equal" do
    t = Multiset{1, 10, 100, 1000}
    lo, hi = t.lower_upper(100, eq: true)
    lo.should eq 100
    hi.should eq 100
  end

  it "lower and upper not equal" do
    t = Multiset{1, 10, 100, 1000}
    lo, hi = t.lower_upper(100, eq: false)
    lo.should eq 10
    hi.should eq 1000
  end

  it "unsafe fetch" do
    t = Multiset{1,2,3,4,5}
    t.unsafe_fetch(2).should eq 3
    t.unsafe_fetch(100).should eq nil
    t.to_a.should eq [1,2,3,4,5]
  end
end
