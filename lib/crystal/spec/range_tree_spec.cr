require "spec"
require "crystal/range_tree"

describe RangeTree do
  it "usage" do
    rt = RangeTree.new(9)
    rt.add 0, 1e6
    rt.add 2, 0
    rt.add 2, 1e9
    rt.add 5, 0
    rt.add 5, 1e9
    rt.add 8, 1e6

    rt[0.., 0..].should eq 6
    rt[0..5, ..1e9.to_i].should eq 5
    rt[0..8, 1e6.to_i..].should eq 4
    rt[2..5, 1e9.to_i..].should eq 2
  end
end
