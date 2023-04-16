require "spec"
require "crystal//square_matrix"

describe SquareMatrix do
  it "usage" do
    m = SquareMatrix(Int32).new("1 1;1 0")
    (m ** 6).inspect.should eq "[[13, 8][8, 5]]"
    (m ** 6)[0,0].should eq 13
  end
end
