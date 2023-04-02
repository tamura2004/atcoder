require "spec"
require "crystal/geography_integer"

describe "GeographyInteger" do
  it "usage segment" do
    a = 0.x + 0.y
    b = 2.x + 4.y
    c = 1.x + 2.y
    d = 0.x + 2.y
    e = 2.x + 2.y
    seg = Segment.new(a, b)
    seg.includes?(c).should eq true
    seg.side(d).should eq 1
    seg.side(e).should eq -1
    seg.same_side?(d, e).should eq false
    seg.includes?(c).should eq true
    c.in?(seg).should eq true
  end

  it "usage triangle" do
    a = 0.x + 0.y
    b = 10.x + 1.y
    c = 2.x + 10.y
    tri = Tri.new(a, b, c)
    tri.includes?(1.x + 5.y).should eq false
    tri.includes?(2.x + 5.y).should eq true
  end
end
