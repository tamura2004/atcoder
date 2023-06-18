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
  end
end
