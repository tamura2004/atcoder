require "spec"
require "crystal/complex"

describe Complex do
  it "usage" do
    z = 1.i + 0
    w = 0.i + 1
    (z + w).should eq (1.i + 1)
  end
end