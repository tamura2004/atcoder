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
    ns.covered_by(0).should eq ({0_i64, 4_i64})
    ns.delete(0)
    ns.mex.should eq 0
  end

  it "usage" do
    st = NekoSet.new
    st << 10_i64
    st << 11_i64
    st << 13_i64
    st << 14_i64
    st << 15_i64
    st << 20_i64

    st.to_a[1..-2].should eq [{10_i64, 11_i64}, {13_i64, 15_i64}, {20_i64, 20_i64}]

    st << 12_i64
    st.to_a[1..-2].should eq [{10_i64, 15_i64}, {20_i64, 20_i64}]

    st << 30_i64
    st.to_a[1..-2].should eq [{10_i64, 15_i64}, {20_i64, 20_i64}, {30_i64, 30_i64}]

    st << 31_i64
    st.to_a[1..-2].should eq [{10_i64, 15_i64}, {20_i64, 20_i64}, {30_i64, 31_i64}]

    st << 9_i64
    st.to_a[1..-2].should eq [{9_i64, 15_i64}, {20_i64, 20_i64}, {30_i64, 31_i64}]

    st.delete(11_i64)
    st.to_a[1..-2].should eq [{9_i64, 10_i64}, {12_i64,15_i64}, {20_i64, 20_i64}, {30_i64, 31_i64}]
  end
end
