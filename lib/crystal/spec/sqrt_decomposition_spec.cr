require "spec"
require "../sqrt_decomposition"

describe SqrtDecompositionRSUM do
  it "usage" do
    rsum = SqrtDecompositionRSUM.new(10)
    10.times do |i|
      rsum[i] = i + 1
    end
    rsum[0,9].should eq 55
  end
end

describe SqrtDecompositionRMQ do
  it "usage" do
    a = [5,1,4,2,3].map(&.to_i64)
    rmq = SqrtDecompositionRMQ.new(a)
    rmq[0,5].should eq 1
    rmq[3,5].should eq 2
  end
end
