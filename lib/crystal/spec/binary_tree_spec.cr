require "spec"
require "../binary_tree"

describe Treap do
  it "rotate right" do
    root = Treap::Node.new(10,10)
    leaf = Treap::Node.new(20,20)
    root.ch[0] = leaf

    new_root = root.rotate(0)

    new_root.key.should eq 20
    new_root.ch[0].key.should eq 0
    new_root.ch[1].key.should eq 10
  end

  it "rotate left" do
    root = Treap::Node.new(10,10)
    leaf = Treap::Node.new(20,20)
    root.ch[1] = leaf

    new_root = root.rotate(1)

    new_root.key.should eq 20
    new_root.ch[0].key.should eq 10
    new_root.ch[1].key.should eq 0
  end

  it "find" do
    t = Treap.new
    t.insert 0,10,3
    t.insert 0,9,2
    t.insert 0,6,1
    
    t[0].should eq 6
    t[1].should eq 9
    t[2].should eq 10
  end
  
  it "erase" do
    t = Treap.new
    t.insert 0,10,3
    t.insert 0,9,2
    t.insert 0,6,1

    t[0].should eq 6
    t[1].should eq 9
    t[2].should eq 10

    t.erase(1)

    t[0].should eq 6
    t[1].should eq 10
  end

  it "erace2" do
    t = Treap.new
    t.insert 0, 1, 1
    t.insert 0, 2, 2
    t.insert 0, 3, 1
    t.insert 0, 4, 4
    t.insert 0, 5, 1
    t.insert 0, 6, 2
    t.insert 0, 7, 1

    t.erase(3)
    t[3].should eq 4
  end

  # it "merge" do
  #   s = Treap.new
  #   s.insert 0,1
  #   s.insert 0,2
  #   s.insert 0,3

  #   t = Treap.new
  #   t.insert 0,4
  #   t.insert 0,5
  #   t.insert 0,6

  #   s.merge(t)
  #   s[4].should eq 4
  # end
end
