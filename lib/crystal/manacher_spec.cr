require "spec"
require "crystal/manacher"

describe "Manacher" do
  it "usage" do
    "abaaababa".manacher.should eq [1,2,1,4,1,2,3,2,1]
  end
end
