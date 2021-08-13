require "spec"
require "../binary_tree"

describe Treap do
  it "nil node" do
    Treap.nil_node.ch[0].val.should eq 0
    Treap.nil_node.ch[1].val.should eq 0
  end

  it "rotate" do
    t = Treap.new
    t.insert 0, 1, 1
    t.insert 1, 2, 2
    t.insert 2, 3, 1

    node = t.root.rotate(0)

    node.val.should eq 1
    node.ch[0].val.should eq 0
    node.ch[1].val.should eq 2
  end

  it "rotate nil side" do
    t = Treap.new
    t.insert 0, 1, 2
    t.insert 1, 2, 1

    t.root.val.should eq 1
    t.root.ch[0].val.should eq 0
    t.root.ch[1].val.should eq 2

    node = t.root.rotate(0)

    node.val.should eq 0
    node.ch[0].val.should eq 0
    node.ch[1].val.should eq 0
  end

  it "insert" do
    t = Treap.new
    t.insert 0, 10
    t.insert 0, 20
    t.insert 2, 15 # => [20, 10, 15]

    t[0].val.should eq 20
    t[1].val.should eq 10
    t[2].val.should eq 15
  end

  it "push" do
    t = Treap.new
    t << 10
    t << 20
    t << 15 # => [10, 20, 15]

    t[0].val.should eq 10
    t[1].val.should eq 20
    t[2].val.should eq 15
  end

  it "erase" do
    t = Treap.new
    t.insert 0, 100, 3
    t.insert 0, 200, 2
    t.insert 0, 300, 1 # => [300,200,100]

    t.erase(1)
    t[1].val.should eq 100
  end

  it "erase" do
    t = Treap.new
    t.insert 0, 100, 1
    t.insert 0, 200, 2
    t.insert 0, 300, 3 # => [300,200,100]

    t.erase(1)
    t[1].val.should eq 100
  end


  it "erase" do
    t = Treap.new
    t.insert 0, 100, 3
    t.insert 1, 200, 2
    t.insert 2, 300, 1

    t.erase(1)

    t[1].val.should eq 300
  end

  it "merge" do
    t = Treap.new
    t << 1
    t << 2
    t << 3
    s = Treap.new
    s << 4
    s << 5
    s << 6
    t.merge(s)

    6.times do |i|
      t[i].val.should eq i + 1
    end
  end

  it "split" do
    t = Treap.new
    6.times do |i|
      t << i + 1
    end

    u, v = t.split(3)
    u[1].val.should eq 2
    v[1].val.should eq 5
  end

  it "lower bound" do
    t = Treap.new
    10.times do |i|
      t << i * 10
    end

    t.lower_bound(19).should eq 2
    t.lower_bound(20).should eq 2
    t.lower_bound(21).should eq 3
  end
end
