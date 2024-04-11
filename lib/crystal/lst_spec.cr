require "spec"
require "crystal/lst"

describe LST do
  it "区間更新、区間加算" do
    st = LST.range_update_range_sum([0, 1, 0, 1].map(&.to_i64))
    st.to_a.should eq [0, 1, 0, 1]
    st[1..2].should eq 1
    st[0..1] = 0_i64
    st.to_a.should eq [0, 0, 0, 1]
    st[1..2].should eq 0
    st[2..3] = 1_i64
    st.to_a.should eq [0, 0, 1, 1]
    st[1..2].should eq 1
  end
end
