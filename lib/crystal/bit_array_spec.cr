require "spec"
require "crystal//bit_array"

describe BitArray do
  it "usage" do
    s = BitArray.new
    t = BitArray.new
    s << 100 # S = {100}
    t << 1000 # S = {1000}
    s.size.should eq 1 # |S| = 1
    s.includes?(100).should eq true
    s.includes?(1000).should eq false
    t.includes?(1000).should eq true
    s += t # S = {100,1000}
    s.size.should eq 2 # |S| = 2
    s.includes?(1000).should eq true

  end
end
