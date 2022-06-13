require "spec"
require "crystal/balanced_tree/treap/multiset"
include BalancedTree::Treap

describe BalancedTree::Treap::Multiset do
  it "usage" do
    t = Multiset{4, 5, 3, 1, 2}
    t.to_a.should eq [1, 2, 3, 4, 5]
    3.in?(t).should eq true
    6.in?(t).should eq false
    t.includes?(3).should eq true
    t.includes?(6).should eq false
  end

  it "insert" do
    t = Multiset{1, 3}
    t.insert(2)
    t.to_a.should eq [1, 2, 3]
  end

  it "<< as insert alias" do
    t = Multiset{1, 3}
    t << 2
    t.to_a.should eq [1, 2, 3]
  end

  it "delete" do
    t = Multiset{1, 2, 2, 3}
    t.delete(2)
    t.to_a.should eq [1, 2, 3]
  end

  it "delete_all" do
    t = Multiset{1, 2, 2, 3}
    t.delete_all(2)
    t.to_a.should eq [1, 3]
  end

  it "shift" do
    t = Multiset{1, 2, 3}
    k = t.shift
    t.to_a.should eq [2, 3]
    k.should eq 1
  end

  it "pop" do
    t = Multiset{1, 2, 3}
    k = t.pop
    t.to_a.should eq [1, 2]
    k.should eq 3
  end

  it "first" do
    t = Multiset{3, 1, 2}
    t.first.should eq 1
  end

  it "min" do
    t = Multiset{3, 1, 2}
    t.min.should eq 1
  end

  it "last" do
    t = Multiset{3, 1, 2}
    t.last.should eq 3
  end

  it "max" do
    t = Multiset{3, 1, 2}
    t.max.should eq 3
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

  it "range to tuple" do
    t = Multiset{1, 10, 100, 1000}
    t.range_to_tuple(-10..).should eq ({-10, Int32::MAX})
    t.range_to_tuple(-10...).should eq ({-10, Int32::MAX})
    t.range_to_tuple(-10..20).should eq ({-10, 21})
    t.range_to_tuple(-10...20).should eq ({-10, 20})
  end

  it "range to tuple" do
    t = Multiset{1, 10, 100, 1000}
    t.range_to_tuple(..10).should eq ({Int32::MIN, 11})
    t.range_to_tuple(...10).should eq ({Int32::MIN, 10})
    t.range_to_tuple(10..).should eq ({10, Int32::MAX})
    t.range_to_tuple(10...).should eq ({10, Int32::MAX})
    t.range_to_tuple(10..20).should eq ({10, 21})
    t.range_to_tuple(10...20).should eq ({10, 20})
  end

  it "get acc" do
    t = Multiset{1, 10, 100, 1000}
    t.get_acc(90..).should eq 1100
    t.get_acc(...90).should eq 11
    t.get_acc(10...101).should eq 110
  end
end
