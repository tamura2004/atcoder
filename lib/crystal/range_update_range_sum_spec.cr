require "spec"
require "crystal/range_update_range_sum"

describe RangeUpdateRangeSum do
  it "usage" do
    st = RURS.new(5)
    st[0] = 10_i64
    st[2] = 20_i64
    st[4] = 40_i64

    # [10, nil, 20, nil, 40]
    st[0..].should eq 70
    st[2..].should eq 60
    st[4..].should eq 40
    st[1..3].should eq 20
    st[..2].should eq 30

    st[3..4] = 5_i64

    # [10, nil, 20, 5, 5]
    st[0..].should eq 40
    st[0..2].should eq 30
    st[2..].should eq 30
    st[4..].should eq 5
    st[1..3].should eq 25
    st[..2].should eq 30
  end
end
