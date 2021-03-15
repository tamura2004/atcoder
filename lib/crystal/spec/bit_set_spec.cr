require "spec"
require "../bit_set"

describe BitSet do
  it "usage" do
    a = BitSet(3).new("101")
    a.inverse.inspect.should eq "010"
  end
end
