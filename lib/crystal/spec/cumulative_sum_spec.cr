require "spec"
require "crystal/cumulative_sum"

describe CumulativeSum do
  it "usage" do
    a = [1,2,3,2]
    cs = CumulativeSum(Int32).new(a)
    cs.n.should eq 4
    cs.a.should eq [1,2,2,3]
    cs.cs.should eq [0,1,3,5,8]
  end

  it "count upper" do
    a = [1,2,3,2]
    cs = CumulativeSum(Int32).new(a)
    cs.count_upper(0).should eq 4
    cs.count_upper(1).should eq 4
    cs.count_upper(2).should eq 3
    cs.count_upper(3).should eq 1
    cs.count_upper(4).should eq 0
  end

  it "count lowerr" do
    a = [1,2,3,2]
    cs = CumulativeSum(Int32).new(a)
    cs.count_lower(0).should eq 0
    cs.count_lower(1).should eq 1
    cs.count_lower(2).should eq 3
    cs.count_lower(3).should eq 4
    cs.count_lower(4).should eq 4
  end

  it "sum upper" do
    a = [1,2,3,2]
    cs = CumulativeSum(Int32).new(a)
    cs.sum_upper(0).should eq 8
    cs.sum_upper(1).should eq 8
    cs.sum_upper(2).should eq 7
    cs.sum_upper(3).should eq 3
    cs.sum_upper(4).should eq 0
  end

  it "sum lowerr" do
    a = [1,2,3,2]
    cs = CumulativeSum(Int32).new(a)
    cs.sum_lower(0).should eq 0
    cs.sum_lower(1).should eq 1
    cs.sum_lower(2).should eq 5
    cs.sum_lower(3).should eq 8
    cs.sum_lower(4).should eq 8
  end
end