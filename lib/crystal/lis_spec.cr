require "spec"
require "../lis.cr"

describe LIS do
  it "basic usage" do
    a = [1,3,5,2,6]
    lis = LIS(Int32).new(a)
    lis.solve.should eq 4
  end

  it "has same num" do
    a = [1,5,5,5,2,2,3]
    lis = LIS(Int32).new(a)
    lis.solve.should eq 3
  end
end


  