require "spec"
require "crystal/tr"

describe TR do
  it "usage" do
    tr = TR(String).new(
      ["a"] * 6,
      -> (x : String, y : String) { x + " " + y }
    )

    tr.sum.should eq "a a a a a a"
    tr[2] = "b"
    tr.sum.should eq "a a b a a a"
  end
end
