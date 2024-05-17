require "spec"
require "crystal/neko_set"

describe NekoSet do
  it "mex" do
    ns = NekoSet.new
    ns << 0
    ns << 1
    ns << 2
    ns << 4
    ns.mex.should eq 3
    ns << 3
    ns.mex.should eq 5
    ns.covered_by(0).should eq ({0, 4})
    ns >> 0
    ns.mex.should eq 0
  end

  it "usage" do
    st = NekoSet.new
    st << 10
    st << 11
    st << 13
    st << 14
    st << 15
    st << 20

    st.to_a.should eq [{10, 11}, {13, 15}, {20, 20}]

    st << 12
    st.to_a.should eq [{10, 15}, {20, 20}]

    st << 30
    st.to_a.should eq [{10, 15}, {20, 20}, {30, 30}]

    st << 31
    st.to_a.should eq [{10, 15}, {20, 20}, {30, 31}]

    st << 9
    st.to_a.should eq [{9, 15}, {20, 20}, {30, 31}]

    st >> 11
    st.to_a.should eq [{9, 10}, {12,15}, {20, 20}, {30, 31}]
  end
end
