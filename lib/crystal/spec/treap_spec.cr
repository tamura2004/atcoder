require "spec"
require "../treap"

describe Treap do
  it "usage" do
    t = Treap(Int32).new
    t.min.should eq nil
    t.max.should eq nil
    t.insert(10)
    t.min.should eq 10
    t.max.should eq 10
    t.insert(20)
    t.min.should eq 10
    t.max.should eq 20
    t.cnt.should eq 2
    t.delete(10)
    t.cnt.should eq 1
    t.min.should eq 20
    t.max.should eq 20
  end

  it "usage pair" do
    t = Treap(Tuple(Int32,Int32)).new
    t.insert({10,40})
    t.insert({30,20})
    t.min.should eq ({10,40})
    t.delete({10,40})
    t.min.should eq ({30,20})
  end
end
