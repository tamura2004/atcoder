require "spec"
require "crystal//st"

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
end
