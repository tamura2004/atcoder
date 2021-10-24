require "spec"
require "crystal/rational/line"

describe Line do
  it "usage" do
    x = Line.new(0,0,10,10)
    y = Line.new(-100,-100,20,20)
    x.should eq y
  end

  it "virtical" do
    x = Line.new(0,0,0,100)
    y = Line.new(0,0,0,200)
    z = Line.new(10,0,10,200)
    x.should eq y
    x.should_not eq z
  end

  it "horizontal" do
    x = Line.new(0,0,100,0)
    y = Line.new(0,0,200,0)
    z = Line.new(10,0,100,10)
    x.should eq y
    x.should_not eq z
  end
end
