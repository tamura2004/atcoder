require "spec"
require "crystal/largest_rectangle_in_a_histgram"

describe LargestRectanbleInAHistgram do
  it "右下がり" do
    n = 7
    a = [7,6,5,4,3,2,1].map(&.to_i64)
    LargestRectanbleInAHistgram.new(n,a).solve.should eq 16
  end

  it "右上がり" do
    n = 7
    a = [1,2,3,4,5,6,7].map(&.to_i64)
    LargestRectanbleInAHistgram.new(n,a).solve.should eq 16
  end

  it "中央が凸" do
    n = 8
    a = [2,4,6,5,4,3,2,1].map(&.to_i64)
    LargestRectanbleInAHistgram.new(n,a).solve.should eq 16
  end

  it "中央が凹" do
    n = 8
    a = [4,3,2,2,2,3,2,4].map(&.to_i64)
    LargestRectanbleInAHistgram.new(n,a).solve.should eq 16
  end
end
