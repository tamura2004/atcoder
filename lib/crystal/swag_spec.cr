require "spec"
require "crystal//swag"

describe SWAG do
  it "usage" do
    swag = SWAG(Int32).new
    swag << 10
    swag << 20
    swag << 30
    swag.sum.should eq 60 # [10, 20, 30]
    swag.shift
    swag.sum.should eq 50 # [20, 30]
    swag.pop
    swag.sum.should eq 20 # [20]
    swag.unshift 100 # [100, 20]
    swag.sum.should eq 120
    swag.pop
    swag.pop
    swag.sum.should eq 0

  end
end
