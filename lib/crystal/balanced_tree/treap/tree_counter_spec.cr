require "spec"
require "crystal/balanced_tree/treap/tree_counter"
include BalancedTree::Treap

describe BalancedTree::Treap::TreeCounter do
  it "usage" do
    t = TreeCounter(Int32, Int64).new
    t[1] = 11_i64
    t[2] = 22_i64
    t[4] = 44_i64
    t[1].should eq 11
    t[2].should eq 22
    t[3].should eq 0

    t.has_key?(1).should eq true
    t.size.should eq 3
    t[1] -= 11
    t.has_key?(1).should eq false
    t.size.should eq 2

    t.min.should eq 2
    t.max.should eq 4

    t[2] += 100
    t[2].should eq 122
    (t.max - t.min).should eq 2

    t.size.should eq 2
  end

  it "負の数はカウントしない" do
    t = TreeCounter{1 => -10}
    t[1].should eq 0
    t.has_key?(1).should eq false
    expect_raises(NilAssertionError) { t.min }
    expect_raises(NilAssertionError) { t.max }
  end
end
