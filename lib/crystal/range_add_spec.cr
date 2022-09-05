require "spec"
require "crystal/range_add"

describe RangeAdd do
  it "usage" do
    st = RangeAdd.new(100)
    st[10..20] = 10
    st[15..25] = -5

    st[9].should eq 0
    st[14].should eq 10
    st[15].should eq 5
    st[20].should eq 5
    st[25].should eq -5
    st[26].should eq 0
  end
end
