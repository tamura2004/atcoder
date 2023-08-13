require "spec"
require "crystal/balanced_tree/treap/tree_map"
include BalancedTree::Treap

describe BalancedTree::Treap::TreeMap do
  it "usage" do
    tr = TreeMap(Int32, Int64).new( -> (x : Int64, y : Int64) { x + y } )
    tr[300] = 1e12.to_i64
    tr[200] = 2e12.to_i64
    tr[100] = 3e12.to_i64
    tr.acc.should eq 6e12.to_i64
    tr[200] = 4e12.to_i64
    tr.acc.should eq 8e12.to_i64

    # [3e12, 4e12, 1e12]

    tail = tr | 200
    tr.acc.should eq 3e12.to_i64
    tail.acc.should eq 5e12.to_i64

    tr + tail

    tr[...200].should eq 3e12.to_i64
    tr[..200].should eq 7e12.to_i64
    tr[200..].should eq 5e12.to_i64
    tr[200...].should eq 5e12.to_i64
    expect_raises NilAssertionError do
      tr[500...]
    end
    tr[500...]?.should eq nil
  end

  it "initi with do block" do
    tr = TreeMap(Int32, Int64).new(default: 0_i64) do |x, y|
      x + y
    end

    tr[100] += 300
    tr[50] += 140
    tr[150] += 20
    tr[50] += 10

    tr[..100].should eq 450
    tr[...100].should eq 150
    tr[500..].should eq 0
  end
end
