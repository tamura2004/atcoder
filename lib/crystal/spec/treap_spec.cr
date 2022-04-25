require "spec"
require "crystal/treap"

describe Treap do
  it "usage" do
    node = Treap{40, 10, 30, 20}
    node.to_a.should eq [10, 20, 30, 40]
  end

  it "split" do
    node = Treap{40, 10, 30, 20}
    fst, snd = node.split(30)
    fst.to_a.should eq [10, 20]
    snd.to_a.should eq [30, 40]
    fst.sum.should eq 30
    snd.sum.should eq 70
  end

  it "split_at" do
    node = Treap{40, 10, 30, 20}
    fst, snd = node.split_at(2)
    fst.to_a.should eq [10, 20]
    snd.to_a.should eq [30, 40]
    fst.sum.should eq 30
    snd.sum.should eq 70
  end

  it "insert" do
    node = Treap{40, 10, 30, 20}
    node << 15
    node.to_a.should eq [10, 15, 20, 30, 40]
  end

  it "merge" do
    fst = Treap{10, 20, 30}
    snd = Treap{40, 50}
    node = fst.merge(snd)
    node.to_a.should eq [10, 20, 30, 40, 50]
  end

  it "merge triple" do
    t1 = Treap{1, 2}
    t2 = Treap{3, 4}
    t3 = Treap{5, 6}
    tr = t1.merge(t2).merge(t3)
    tr.to_a.should eq [1, 2, 3, 4, 5, 6]
  end

  it "+" do
    t1 = Treap{1, 2}
    t2 = Treap{3, 4}
    t3 = Treap{5, 6}
    (t1 + t2 + t3).to_a.should eq [1, 2, 3, 4, 5, 6]
  end

  it "merge nil node" do
    t1 = Treap(Int32).new
    t2 = Treap(Int32).new
    t3 = t1.merge(t2)
    t3.root.should eq nil
  end

  it "delete" do
    node = Treap{40, 10, 30, 20}
    node.delete(40)
    node.delete(30)
    node.to_a.should eq [10, 20]
  end

  it "includes?" do
    node = Treap{40, 10, 30, 20}
    node.includes?(20).should eq true
    node.includes?(25).should eq nil
  end

  it "size" do
    node = Treap{40, 10, 30, 20}
    node.size.should eq 4
  end
end
