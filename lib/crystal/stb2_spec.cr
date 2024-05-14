require "spec"
require "crystal/stb2"

describe Stb2 do
  it "usage" do
    st = Stb2.new([3, 1, 4, 1])
    st.add(1, 3, 5) # => [3, 6, 9, 1]
    st.debug
    st.sum(2, 3).should eq 9
    st.sum(1, 2).should eq 6
  end
end
