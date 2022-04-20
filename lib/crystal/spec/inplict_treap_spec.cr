require "spec"
require "crystal//inplict_treap"

alias Tree = InplictTreap

describe InplictTreap do
  it "usage" do
    node = Tree{40, 10, 30, 20}
    node.inspect.should eq "(( 10 ( 20 )) 30 ( 40 ))"
  end

  it "split" do
    node = Tree{40, 10, 30, 20}
    fst, snd = node.split(30)
    fst.inspect.should eq "( 10 ( 20 ))"
    snd.inspect.should eq "(( 30 ) 40 )"
  end

  it "insert" do
    node = Tree{40, 10, 30, 20}
    node << 15
    node.inspect.should eq "( 10 ((( 15 ) 20 ) 30 ( 40 )))"
  end

  it "merge" do
    fst = Tree{10, 20, 30}
    snd = Tree{40, 50}
    node = fst.merge(snd)
    node.inspect.should eq "(((( 10 ) 20 ) 30 ( 40 )) 50 )"
  end

  it "delete" do
    node = Tree{40, 10, 30, 20}
    node.delete(40)
    node.delete(30)
    node.inspect.should eq "(( 10 ) 20 )"
  end
end
