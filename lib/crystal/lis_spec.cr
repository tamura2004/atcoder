require "spec"
require "crystal/lis.cr"

describe LIS do
  it "basic usage" do
    a = [1, 3, 5, 2, 6]
    lis = a.lis
    lis.should eq 4 # [1,3,5,6]
    typeof(lis).should eq Int32
  end

  it "has same num" do
    a = [1, 5, 5, 5, 2, 2, 3]
    lis = a.lis
    lis.should eq 3 # [1,2,3]
  end

  it "数列全体が増加列" do
    a = [-3, -2, -1, 0, 1, 2, 3]
    lis = a.lis
    lis.should eq 7
  end

  it "増加列が最大１" do
    a = [3, 2, 1, 0, -1, -2, -3]
    lis = a.lis
    lis.should eq 1
  end
end
