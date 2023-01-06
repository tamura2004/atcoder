require "spec"
require "crystal/fps"
include FPS

describe FPS do
  it "usage" do
    s = "x^15-x^14-2*x^13+2*x^11+4*x^10-x^9-3*x^8-3*x^7-x^6+4*x^5+2*x^4-2*x^2-x+1"
    want = [1, -1, -2, 0, 2, 4, -1, -3, -3, -1, 4, 2, 0, -2, -1, 1]
    Parser.new(s).expr.to_a.should eq want
  end

  it "usage" do
    s = "x^3"
    Parser.new(s).expr.to_a.should eq [0,0,0,1]
  end

  it "rat_expr" do
    s = "(x^2-1)/(-x^3+2*x+1)"
    Parser.new(s).rat_expr.to_pair.should eq ({[-1, 0, 1], [1, 2, 0, -1]})
  end
end
