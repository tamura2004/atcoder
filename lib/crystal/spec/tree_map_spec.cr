require "spec"
require "crystal//tree_map"

describe TreeMap do
  it "usage" do
    tr = TreeMap(Int32,Int32).new
    tr[100] = 101
    tr[200] = 201
    tr[300] = 301

    tr.lower(250).should eq 201
  end
end
