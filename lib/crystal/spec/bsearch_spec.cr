require "spec"
require "../bsearch"

describe BSearch do
  it "条件がloで常に成立するとき最大のloを求める" do
    BSearch(Int32).new do |i|
      i * i < 200
    end.max_of(0,200).should eq 14
  end

  it "条件がhiで常に成立するとき最小のhiを求める" do
    BSearch(Int32).new do |i|
      i * i > 200
    end.min_of(0,200).should eq 15
  end
end
