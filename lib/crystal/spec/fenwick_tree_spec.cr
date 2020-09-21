require "spec"
require "../fenwick_tree"

describe FenwickTree do
  it "usage: init by array" do
    bit = FenwickTree.new([1, 2, 4])
    bit[3].should eq 7
    bit[1] = 8 # add 8
    bit[3].should eq 15
    bit[1] = -8
    bit[3].should eq 7
  end

  it "index error" do
    bit = FenwickTree(Int32).new(10)
    expect_raises( ArgumentError, "FenewickTree#add: index 0 must not be zero or negative" ) { bit[0] = 1 }
    expect_raises( ArgumentError, "FenewickTree#add: index -1 must not be zero or negative" ) { bit[-1] = 1 }
  end

  it "solve Chokudai Speed Run 001 J" do
    cases = [
      { 5, [3,1,5,4,2] , 5 },
      { 6, [1,2,3,4,5,6] , 0 },
      { 7, [7,6,5,4,3,2,1] , 21 },
      { 20, [19,11,10,7,8,9,17,18,20,4,3,15,16,1,5,14,6,2,13,12],114}
    ]
    cases.each do |(n,a,ans)|
      ChokudaiSpeedRun001J.new(n,a).solve.should eq ans
    end
  end
end

class ChokudaiSpeedRun001J
  getter n : Int32
  getter a : Array(Int32)

  def initialize(@n, @a)
  end

  def solve
    bit = FenwickTree(Int32).new(n)
    ans = 0_i64
    1.upto(n) do |i|
      j = a[i-1]
      ans += bit[n] - bit[j]
      bit[j] = 1
    end
    ans
  end
end
