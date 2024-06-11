require "spec"
require "crystal/dynamic_segment_tree"

describe DynamicSegmentTree do
  it "usage" do
    st = DynamicSegmentTree(Int32).new
    st.get(1_i64, 2_i64).should eq 0
    st.set(1_i64, 10)
    st.set(2_i64, 20)
    st.get(1_i64, 3_i64).should eq 30

  end
end
