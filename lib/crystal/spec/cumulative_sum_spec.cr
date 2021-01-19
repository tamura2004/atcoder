require "spec"
require "../cumulative_sum"

describe CumulativeSum do
  it "usage" do
    a = [1,2,4,8]
    cs = CumulativeSum(Int32).new(a)
    cs.left.should eq [0,1,3,7,15]
    cs.right.should eq [15,14,12,8,0]
  end

  it "gcd" do
    a = [2,6,30,210]
    cs = CumulativeSum(Int32).new(a){|a,b|a.gcd(b)}
    cs.left.should eq [0,2,2,2,2]
    cs.right.should eq [2,6,30,210,0]
  end
end