require "spec"
require "crystal/complex/circle"

describe Circle do
  it "cross" do
    a = Circle.new 10, 0, 10
    b = Circle.new 30, 0, 20
    a.intersect?(b).should eq true
  end

  it "touch" do
    a = Circle.new 0, 0, 10
    b = Circle.new 30, 0, 20
    a.intersect?(b).should eq true
  end

  it "apart" do
    a = Circle.new 0, 0, 10
    b = Circle.new 30, 1, 20
    a.intersect?(b).should eq false
  end

  it "inner" do
    a = Circle.new 0, 0, 10
    b = Circle.new 1, 1, 200
    a.intersect?(b).should eq false
  end

  it "dist cross" do
    a = Circle.new 10, 0, 10
    b = Circle.new 30, 0, 20
    a.dist(b).should eq 0_f64
  end

  it "dist touch" do
    a = Circle.new 0, 0, 10
    b = Circle.new 30, 0, 20
    a.dist(b).should eq 0_f64
  end

  it "dist apart" do
    a = Circle.new 0, 0, 10
    b = Circle.new 31, 0, 20
    a.dist(b).should eq 1
  end

  it "inner" do
    a = Circle.new 0, 0, 10
    b = Circle.new 0, 0, 200
    a.dist(b).should eq 190
  end

end
