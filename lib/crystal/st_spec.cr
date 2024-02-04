require "spec"
require "crystal/st"

describe ST do
  it "usage" do
    st = ST.new([1, 2, 3]) do |x, y|
      x + y
    end

    st.sum.should eq 6
    st[0..].should eq 6
    st[1..].should eq 5
    st[2..].should eq 3
    st.get_or_else(3.., 0).should eq 0
    st[-3..].should eq 6
    st.get_or_else(10.., 0).should eq 0
  end

  it "bsearch" do
    #     0,1,2,3,4,5,6,7,8
    st = [3, 1, 4, 1, 5, 9, 2, 6, 5].to_st_max
    st.bsearch(3, &.>= 9).should eq 5
    st.bsearch(5, &.>= 9).should eq 5
    st.bsearch(6, &.>= 9).should eq nil
    st.bsearch(0, &.>= 5).should eq 4
    st.bsearch(3, &.>= 5).should eq 4
    st.bsearch(5, &.>= 5).should eq 5
    st.bsearch(6, &.>= 5).should eq 7
  end
end
