require "spec"
require "crystal//cs2d"

describe CS2D do
  it "usage" do
    cs = CS2D(Int32).new(3, 3)
    3.times do |y|
      3.times do |x|
        cs[y, x] = y + x * 10
      end
    end

    cs[0, 1, 0, 1].should eq 0
    cs[0, 2, 0, 1].should eq 1
    cs[0, 1, 0, 2].should eq 10
    cs[0, 2, 0, 2].should eq 22

    cs[0...1, 0...1].should eq 0
    cs[0...2, 0...1].should eq 1
    cs[0...1, 0...2].should eq 10
    cs[0...2, 0...2].should eq 22

    cs[0..0, 0..0].should eq 0
    cs[0..1, 0..0].should eq 1
    cs[0..0, 0..1].should eq 10
    cs[0..1, 0..1].should eq 22
  end
end
