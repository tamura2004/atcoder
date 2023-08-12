require "spec"
require "crystal/balanced_tree/treap/tree_map"
include BalancedTree::Treap

describe BalancedTree::Treap::TreeMap do
  it "usage" do
    tr = TreeMap(Int32, Int64).new( -> (x : Int64, y : Int64) { x + y } )
    tr[4_000_000] = 7_000_000_000_i64
    tr[3_000_000] = 8_000_000_000_i64
    tr[2_000_000] = 9_000_000_000_i64
    tr[1_000_000] = 6_000_000_000_i64
    
  end
end
