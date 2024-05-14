require "spec"
require "crystal/range_chmin_range_sum"

describe RangeChminRangeSum do
  it "usage" do
    values = [3, 1, 4, 1, 5]
    st = values.to_range_chmin_range_sum
    # st[0..].should eq 14
    st[1..3] = 2 # => [3, 1, 2, 1, 5]
    # st[0..].should eq 12
    pp st.st.v[1..10]
    st[2..2].should eq 2

    # st[1..2].should eq 3
    # st[2..4] = 3 # => [3, 1, 2, 1, 3]
    # st[..4].should eq 10
  end
end

# 5
# 12
# 3       5
# 7       5
# 3   2   5   0
# 4   3   5   0
# 3 1 4 1 5 0 0 0