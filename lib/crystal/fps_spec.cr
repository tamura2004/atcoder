require "spec"
require "crystal/fps"

describe FPS do
  it "usage" do
    "1-x+5x^6".to_expr.to_a.should eq [1, -1, 0, 0, 0, 0, 5]
    "1 - x + 5x^6".to_expr.to_a.should eq [1, -1, 0, 0, 0, 0, 5]
    "5x^6 - x + 1".to_expr.to_a.should eq [1, -1, 0, 0, 0, 0, 5]
    "15".to_expr.to_a.should eq [15]
    "x".to_expr.to_a.should eq [0, 1]
    "x^5".to_expr.to_a.should eq [0, 0, 0, 0, 0, 1]
  end
end
