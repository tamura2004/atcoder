require "spec"
require "crystal/doubling"

describe Doubling do
  it "itself test" do
    obj = Doubling(Int32).new(10, &.itself)
    10.times do |i|
      got = obj.solve(from: i, step: 100)
      got.should eq i
    end
  end

  it "random test" do
    obj = Doubling(Int32).new(10){rand(10)}
    10.times do
      got = obj.solve(from: 0, step: 100)
      want = obj.solve2(from: 0, step: 100)
      got.should eq want
    end
  end

  it "nilable add" do
    obj = Doubling(Int32).new(10){rand(10)}
    obj.add(10, 20).should eq 30
    obj.add(nil, 20).should eq 20
    obj.add(10, nil).should eq 10
    obj.add(nil, nil).should eq nil
    obj.add(Int32::MAX, Int32::MAX).should eq Int32::MAX
  end

  it "cumulative sum" do
    obj = Doubling(Int32).new(10, &.itself)
    obj.sum2(from: 3, step: 3).should eq 12
  end

  it "random sum" do
    obj = Doubling(Int32).new(10,12){rand(10)}
    1000.times do
      got = obj.sum(from: 0, step: 100)
      want = obj.sum2(from: 0, step: 100)
      if got != want
        pp! obj
      end
      got.should eq want
    end
  end

  it "corner sum" do
    a = [4,4,4,0,7,7,2,7,5,2]
    obj = Doubling(Int32).new(10,3){|i| a[i] }
    got = obj.sum(from: 0, step: 2)
    want = obj.sum2(from: 0, step: 2)
    if got != want
      pp! obj
    end
    got.should eq want
  end

end
