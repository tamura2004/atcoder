require "spec"
require "crystal/convex_hull"

describe "ConvexHull" do
  it "usage" do
    dots = [
      0.x + 0.y,
      1.x - 1.y,
      2.x - 3.y,
      1.x + 3.y,
      2.x + 1.y,
      10.x + 0.y,
    ]
    convex_hull(dots).should eq [
      0.x + 0.y,
      1.x + 3.y,
      10.x + 0.y,
      2.x - 3.y,
    ]
  end
end
