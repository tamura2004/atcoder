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

# 区間更新、１点読み出し、最小値
describe SqrtDecompositionRangeUpdateQuery do
  it "usage" do
    rmq = SqrtDecompositionRangeUpdateQuery.new(100_000)
    rmq[0, 100_000] = 100_i64
    rmq[0].should eq 100
    rmq[1].should eq 100
    rmq[5000].should eq 100
    rmq[99_999].should eq 100
    rmq[100_000].should eq Int64::MAX
    
    rmq[100, 90_000] = 50_i64
    rmq[0].should eq 100
    rmq[1].should eq 100
    rmq[99].should eq 100
    rmq[100].should eq 50
    rmq[101].should eq 50
    rmq[5000].should eq 50
    rmq[89_999].should eq 50
    rmq[90_000].should eq 100
    rmq[90_001].should eq 100
    rmq[99_999].should eq 100
    rmq[100_000].should eq Int64::MAX

    rmq[5_000, 95_000] = 25_i64
    rmq[0].should eq 100
    rmq[1].should eq 100
    rmq[99].should eq 100
    rmq[100].should eq 50
    rmq[101].should eq 50
    rmq[4999].should eq 50
    rmq[5000].should eq 25
    rmq[5001].should eq 25
    rmq[89_999].should eq 25
    rmq[90_000].should eq 25
    rmq[90_001].should eq 25
    rmq[94_999].should eq 25
    rmq[95_000].should eq 100
    rmq[95_001].should eq 100
    rmq[99_999].should eq 100
    rmq[100_000].should eq Int64::MAX
  end
end

