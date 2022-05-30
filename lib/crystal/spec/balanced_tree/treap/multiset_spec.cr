require "spec"
require "crystal/balanced_tree/treap/multiset"
include BalancedTree::Treap

describe BalancedTree::Treap::Multiset do
  it "usage" do
    t = Multiset{10,20,30}
    fst, snd = t.split(20)
    pp! fst
    pp! snd
    pp! fst + snd + Multiset.new(30)
  end
end
