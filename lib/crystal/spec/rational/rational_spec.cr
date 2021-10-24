require "spec"
require "crystal/rational/rational"

describe Rational do
  it "usage" do
    x = Rational.new(-100,200)
    y = Rational.new(1,-2)
    z = Rational.new(1,2)
    x.should eq y
    x.should_not eq z
  end
  
  it "virtical" do
    x = Rational.new(0,10)
    y = Rational.new(0,-200)
    z = Rational.new(0,200)
    x.should eq y
    x.should eq z
  end
  
  it "horizontal" do
    x = Rational.new(10,0)
    y = Rational.new(-200,0)
    z = Rational.new(200, 0)
    x.should eq y
    x.should eq z
  end
  
  it "zero" do
    x = Rational.new(0,0)
    y = Rational.new(0,0)
    z = Rational.new(0, 0)
    x.should eq y
    x.should eq z
  end
end
