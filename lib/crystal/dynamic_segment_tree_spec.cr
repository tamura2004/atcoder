require "spec"
require "crystal/dynamic_segment_tree"

describe DynamicSegmentTree do
  it "usage" do
    st = DynamicSegmentTree(Int32).new
    st.get(1_i64, 2_i64).should eq 0
    st.set(1_i64, 1000)
    st.set(2_i64, 2000)
    pp! st.to_a
    st.get(1_i64, 2_i64).should eq 1000

  end
end
