require "spec"
require "crystal/stb2"

describe Stb2 do
  it "usage" do
    st = Stb2.new([3, 1, 4, 1])
    st[0..2] = 2 # => [2, 1, 2, 1]
    st.debug
    st[0..0].should eq 2
    st[1..3].should eq 4
  end
end
