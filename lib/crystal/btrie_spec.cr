require "spec"
require "crystal//btrie"

describe BTrie do
  it "usage as set" do
    bt = BTrie.new
    bt.add 1
    bt.add 3
    bt.add 300
    bt.add 3
    bt.to_a.should eq [1, 3, 300]
  end

  it "usage as multiset" do
    bt = BTrie.new(multi: true)
    bt.add 1
    bt.add 3
    bt.add 300
    bt.add 3
    bt.to_a.should eq [1, 3, 3, 300]
  end
end
