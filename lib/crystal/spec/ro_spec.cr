require "spec"
require "../ro"

describe Ro do
  it "usage" do
    a = [1, 2, 3, 4, 5, 3]
    obj = Ro.new(0, 10) { |i| i && a[i] }

    obj.lo.should eq 3
    obj.hi.should eq 6
    6.times do |i|
      obj.get(i).should eq i
    end
    obj.get(6).should eq 3
    obj.get(7).should eq 4
    obj.get(307).should eq 4
    obj.get(300000007).should eq 4
  end

  it "no lead" do
    a = [0]
    obj = Ro.new(0, 10) { |i| i && a[i] }

    obj.lo.should eq 0
    obj.hi.should eq 1
    obj.get(0).should eq 0
    obj.get(7).should eq 0
    obj.get(307).should eq 0
    obj.get(300000007).should eq 0
  end

  it "long tail" do
    obj = Ro.new(0, 101) { |i| i < 100 ? i + 1 : i - 1 }

    obj.lo.should eq 99
    obj.hi.should eq 101
    obj.get(0).should eq 0
    obj.get(7).should eq 7
    obj.get(307).should eq 99
    obj.get(300000007).should eq 99
  end
end

