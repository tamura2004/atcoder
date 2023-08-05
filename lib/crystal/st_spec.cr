require "spec"
require "crystal/st"

describe ST do
  it "usage" do
    st = ST(String).new(
      values: ["a", "b", "c"],
      fxx: ->(x : String, y : String) { y + " " + x }
    )
    st.sum.should eq "c b a"
    st[1] = "z"
    st.sum.should eq "c z a"
  end

  it "to_st_sum" do
    st = 10.to_st_sum
    5.times do |i|
      st[i] = i.to_i64
    end
    st[1..2].should eq 3
    st[1...2].should eq 1
    st[...2].should eq 1
    st[..2].should eq 3
    st[3..].should eq 7
    st[3...].should eq 7
    st[5..]?.should eq nil
  end

  it "to_st_min" do
    st = 10.to_st_min
    5.times do |i|
      st[i] = i.to_i64
    end
    st[1..2].should eq 1
    st[1...2].should eq 1
    st[...2].should eq 0
    st[..2].should eq 0
    st[3..].should eq 3
    st[3...].should eq 3
    st[5..]?.should eq nil
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
