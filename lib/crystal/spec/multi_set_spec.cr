require "spec"
require "../multi_set.cr"

describe MultiSet do
  it "find" do
    m = MultiSet.new
    m << 20
    m << 10
    m.find(20).should eq true
    m.find(30).should eq false
  end
  
  it "delete" do
    m = MultiSet.new
    m << 20
    m << 10
    m.delete(20)
    m.find(20).should eq false
  end
  
  it "split" do
    m = MultiSet.new
    m.insert(10, 100)
    m.insert(10, 200)
    m.insert(10, 300)
    m.insert(10, 400)
    m.insert(20, 110)
    m.insert(20, 210)
    m.insert(20, 310)
    m.insert(20, 410)
    left, right = m.split(20)
  end

  it "merge" do
    left = MultiSet.new
    left << 10
    left << 20
    left << 30
    right = MultiSet.new
    right << 40
    right << 50
    right << 60
    left.merge(right)

    left.min.should eq 10
    left.max.should eq 60
    left.debug
    left.delete 60
  end
end
