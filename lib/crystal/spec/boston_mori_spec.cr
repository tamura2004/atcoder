require "spec"
require "crystal/boston_mori"
require "crystal/fps"

describe BostonMori do
  it "usage" do
    n = 50
    a = [1, 0, 0, 0, 1, 1, 3]
    b = [1, -1, -2, 0, 2, 4, -1, -3, -3, -1, 4, 2, 0, -2, -1, 1]
    ans = BostonMori.new(a, b).solve(n - 6)
    ans.should eq 80132
  end

  it "parse from string" do
    n = 50
    s = "3*x^6+x^5+x^4+1"
    t = "x^15-x^14-2*x^13+2*x^11+4*x^10-x^9-3*x^8-3*x^7-x^6+4*x^5+2*x^4-2*x^2-x+1"
    ans = BostonMori.new(s, t).solve(n - 6)
    ans.should eq 80132
  end
end
