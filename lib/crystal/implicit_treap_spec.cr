require "spec"
require "crystal/implicit_treap"

alias Tree = ImplicitTreap

describe ImplicitTreap do
  it "usage" do
    node = Tree.new([40, 10, 30, 20])
    node.to_a.should eq [40, 10, 30, 20]
  end

  it "split" do
    node = Tree{40, 10, 30, 20}
    fst, snd = node.split(2)
    fst.to_a.should eq [40, 10]
    snd.to_a.should eq [30, 20]

    node = Tree{40, 10, 30, 20}
    fst, snd = node.split(0)
    fst.to_a.should eq [] of Int32
    snd.to_a.should eq [40, 10, 30, 20]
  end

  it "insert" do
    node = Tree{40, 10, 30, 20}
    node << 15
    node.to_a.should eq [40, 10, 30, 20, 15]
  end

  it "merge" do
    fst = Tree{10, 20, 30}
    snd = Tree{40, 50}
    node = fst.merge(snd)
    node.not_nil!.to_a.should eq [10, 20, 30, 40, 50]
  end

  it "delete" do
    node = Tree{40, 10, 30, 20}
    node.delete(2)
    node.delete(1)
    node.to_a.should eq [40, 20]
  end

  it "add and min" do
    node = Tree{1, 1, 2, 2}
    node[1..2] = 10
    node[1..2].should eq 11
    node[0..1].should eq 1
    node[2..3].should eq 2
    node[0..].should eq 1
    node[..3].should eq 1
    node.to_a.should eq [1, 11, 12, 2]
  end

  it "first" do
    node = Tree{40, 10, 30, 20}
    node.delete(0)
    node.first.should eq 10
  end

  it "at" do
    node = Tree{40, 10, 30, 20}
    node[0].should eq 40
    node[1].should eq 10
    node[2].should eq 30
    node[3].should eq 20

    node[-4].should eq 40
    node[-3].should eq 10
    node[-2].should eq 30
    node[-1].should eq 20
  end

  it "reverse" do
    node = Tree{40, 10, 30, 20}
    node.reverse(1..2)
    node[0].should eq 40
    node[1].should eq 30
    node[2].should eq 10
    node[3].should eq 20

    node[-4].should eq 40
    node[-3].should eq 30
    node[-2].should eq 10
    node[-1].should eq 20
    node.to_a.should eq [40, 30, 10, 20]
  end

  it "rotate" do
    node = Tree{0, 1, 2, 3, 4, 5, 6}
    node.rotate(1..5, 3)
    7.times { |i| node[i] }
    node.to_a.should eq [0, 3, 4, 5, 1, 2, 6]
  end

  it "update" do
    node = Tree{1,2,3}
    node[0],node[2] = node[2], node[0]
    node.to_a.should eq [3,2,1]
  end
end
