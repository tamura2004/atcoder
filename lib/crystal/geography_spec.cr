require "spec"
require "crystal/geography"

describe Line do
  it "usage" do
    p1 = Point.new(0, 0)
    p2 = Point.new(1, 0)
    p3 = Point.new(1, 1)
    p4 = Point.new(0, 1)
    
    l1 = Line.new(p1, p2)
    l2 = Line.new(p2, p3)
    l3 = Line.new(p3, p4)
    
    l1.same?(l2).should eq false
    
    l1.intersect?(l1).should eq true
    l1.intersect?(l2).should eq true
    l1.intersect?(l3).should eq false
    
    l1.crosspoint(l2).should eq p2
    
    line0 = Line.new(Point.new(3, 3), Point.new(4, 1))
    line1 = Line.new(Point.new(8, 3), Point.new(7, 1))
    line0.crosspoint(line1).should eq Point.new(5.5, -2)
    
    line2 = line0.virtical_bisector
    line3 = line1.virtical_bisector
    line2.crosspoint(line3).should eq Point.new(5.5, 3)
  end
  
  it "外接円の中心" do
    a = Point.new(0,0)
    b = Point.new(2,0)
    c = Point.new(0,2)
    p3 = Point.new(1, 1)
    a.outer_center(b,c).should eq p3
  end

end
