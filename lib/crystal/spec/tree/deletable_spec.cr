require "spec"
require "crystal/tree/deletable"

describe Deletable do
  it "usage" do
    g = Tree.new(7)
    g.add 7,6
    g.add 6,4
    g.add 6,5
    g.add 4,1
    g.add 5,2
    g.add 5,3
    dl = Deletable.new(g, 6)
    dl.to_a(6).sort.should eq [0,1,2,3,4,5,6]
    dl.min(4).should eq 9
    dl.max(3).should eq 12
    dl.min(0).should eq 0
    dl.max(0).should eq 0
    dl.dead[1].should eq false
    dl.dead[2].should eq false
    dl.delete(4)
    dl.min(4).should eq 10
    dl.max(3).should eq 9
    dl.dead[1].should eq true
    dl.dead[2].should eq true
    dl.to_a(6).sort.should eq [0,3,5,6]
    dl.rollback
    dl.dead[1].should eq false
    dl.dead[2].should eq false
  end

  it "usage 2" do
    g = Tree.new(3)
    g.add 1, 2
    g.add 3, 2
    dl = Deletable.new(g)
    dl.dead[2] = true
    dl.to_a(1).sort.should eq [0,1]
  end
end
