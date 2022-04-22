require "spec"
require "crystal/treap"

describe Treap do
  it "usage" do
    node = Treap{40, 10, 30, 20}
    node.inspect.should eq "(( 10 ( 20 )) 30 ( 40 ))"
  end

  it "split" do
    node = Treap{40, 10, 30, 20}
    fst, snd = node.split(30)
    fst.inspect.should eq "( 10 ( 20 ))"
    snd.inspect.should eq "(( 30 ) 40 )"
  end

  it "insert" do
    node = Treap{40, 10, 30, 20}
    node << 15
    node.inspect.should eq "( 10 ((( 15 ) 20 ) 30 ( 40 )))"
  end

  it "merge" do
    fst = Treap{10, 20, 30}
    snd = Treap{40, 50}
    node = fst.merge(snd)
    node.inspect.should eq "(((( 10 ) 20 ) 30 ( 40 )) 50 )"
  end

  it "delete" do
    node = Treap{40, 10, 30, 20}
    node.delete(40)
    node.delete(30)
    node.inspect.should eq "(( 10 ) 20 )"
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
