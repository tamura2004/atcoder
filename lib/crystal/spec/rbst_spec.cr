require "spec"
require "../rbst"

describe RBST do
  it "init nil tree" do
    t = RBST(Int32).new
    t.nil_tree?.should eq true
    t.size.should eq 0
  end

  it "init tree" do
    t = RBST{1,2,3}
    t.nil_tree?.should eq false
    t.size.should eq 3
  end

  it "merge" do
    left = RBST{1,2,3}
    right = RBST{4,5,6}
    left.merge(right).size.should eq 6
  end
end
