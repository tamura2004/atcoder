require "spec"
require "../multi_set.cr"

describe MultiSet do
  it "size" do
    m = MultiSet.new
    m.size.should eq 0
    m.insert 10, 1
    m.size.should eq 1
  end

  it "find" do
    m = MultiSet.new
    m.insert 10, 1
    m.insert 20, 3
    m.insert 30, 2
    m.size.should eq 3
    m.find(Int64::MIN).should eq false
    m.find(Int64::MAX).should eq false
    m.find(0).should eq false
    m.find(10).should eq true
    m.find(20).should eq true
    m.find(30).should eq true
  end

  it "delete" do
    m = MultiSet.new
    m.insert 10, 1
    m.insert 20, 3
    m.insert 30, 2
    m.delete(0)
    m.delete(Int64::MIN)
    m.delete(Int64::MAX)
    m.delete(10)
    m.find(10).should eq false
    m.find(20).should eq true
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
    left.size.should eq 6

    left.min.should eq 10
    left.max.should eq 60
    left.delete 60
    left.size.should eq 5

    ans = [] of Int64
    left.each do |val|
      ans << val
    end
    ans.should eq [10,20,30,40,50]
  end

  it "range split" do
    m = MultiSet.new
    m << 1
    m << 3
    m << 6
    m << 9
    m << 15

    mid, both = m.split(3..9)
    mid.to_a.should eq [3,6,9]
    both.to_a.should eq [1,15]
  end

  it "range split" do
    m = MultiSet.new
    m << 1
    m << 3
    m << 6
    m << 9
    m << 15

    mid, both = m.split(3...9)
    mid.to_a.should eq [3,6]
    both.to_a.should eq [1,9,15]
  end

end
