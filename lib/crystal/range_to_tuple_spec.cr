require "spec"
require "crystal/range_to_tuple"

describe RangeToTuple do
  it "usage" do
    RangeToTuple(Int32).from(..10).should eq ({Int32::MIN, 11})
    RangeToTuple(Int32).from(...10).should eq ({Int32::MIN, 10})
    RangeToTuple(Int32).from(..10, 0).should eq ({0, 11})
    RangeToTuple(Int32).from(...10, 0).should eq ({0, 10})
    RangeToTuple(Int32).from(..10, min: 0).should eq ({0, 11})
    RangeToTuple(Int32).from(...10, min: 0).should eq ({0, 10})
    RangeToTuple(Int32).from(10..).should eq ({10, Int32::MAX})
    RangeToTuple(Int32).from(10...).should eq ({10, Int32::MAX})
    RangeToTuple(Int32).from(10.., max: 100).should eq ({10, 100})
    RangeToTuple(Int32).from(10..., max: 100).should eq ({10, 100})
    RangeToTuple(Int32).from(10..20).should eq ({10, 21})
    RangeToTuple(Int32).from(10...20).should eq ({10, 20})
  end

  it "usage" do
    RangeToTuple(Int64).from(..10).should eq ({Int64::MIN, 11})
    RangeToTuple(Int64).from(...10).should eq ({Int64::MIN, 10})
    RangeToTuple(Int64).from(..10, 0).should eq ({0, 11})
    RangeToTuple(Int64).from(...10, 0).should eq ({0, 10})
    RangeToTuple(Int64).from(..10, min: 0).should eq ({0, 11})
    RangeToTuple(Int64).from(...10, min: 0).should eq ({0, 10})
    RangeToTuple(Int64).from(10..).should eq ({10, Int64::MAX})
    RangeToTuple(Int64).from(10...).should eq ({10, Int64::MAX})
    RangeToTuple(Int64).from(10.., max: 100).should eq ({10, 100})
    RangeToTuple(Int64).from(10..., max: 100).should eq ({10, 100})
    RangeToTuple(Int64).from(10..20).should eq ({10, 21})
    RangeToTuple(Int64).from(10...20).should eq ({10, 20})
  end
end
