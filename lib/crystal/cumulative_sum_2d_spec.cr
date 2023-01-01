require "spec"
require "crystal/cumulative_sum_2d"
require "crystal/matrix"

describe CumulativeSum2D do
  it "usage" do
    m = Matrix(Int32).new([
      [1, 2, 3, 4, 5],
      [2, 3, 4, 5, 6],
      [3, 4, 5, 6, 7],
      [4, 5, 6, 7, 8],
    ])
    cs = CS2D.new(m)
    cs[1.y + 1.x..2.y + 3.x].should eq 27
    cs[1.y + 1.x...3.y + 4.x].should eq 27
    cs[..1.y + 1.x].should eq 8
    cs[2.y + 3.x..].should eq 28
  end
end