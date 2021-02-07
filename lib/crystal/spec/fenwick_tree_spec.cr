require "spec"
require "../fenwick_tree"

describe "inversion number" do
  it "usage" do
    a = [3,2,1]
    inversion_number(a).should eq 3
  end

  it "overflow" do
    n = 100000_i64
    a = (1..100000).to_a.reverse
    want = (n-1)*n//2
    inversion_number(a).should eq want
  end
end

describe FenwickTree do
  it "usage: init empty array" do
    bit = FenwickTree(Int64).new(10)
    bit[1].should eq 0
    bit[3].should eq 0
    bit[5].should eq 0
    bit[1] = 1
    bit[3] = 2
    bit[5].should eq 3
  end

  it "usage: init by array" do
    bit = FenwickTree.new([1, 2, 4])
    bit[3].should eq 7
    bit[1] = 8 # add 8
    bit[3].should eq 15
    bit[1] = -8
    bit[3].should eq 7
  end

  it "bsearch" do
    bit = FenwickTree.new([1,2,2,2,2,2])
    # 1 3 5 7 9 11
    bit.bsearch(0).should eq 0
    bit.bsearch(1).should eq 1
    bit.bsearch(5).should eq 3
    bit.bsearch(6).should eq 4
    bit.bsearch(7).should eq 4
    bit.bsearch(1).should eq 1
    bit.bsearch(13).should eq 7
    bit.bsearch(1300).should eq 7
  end

  it "index error" do
    bit = FenwickTree(Int32).new(10)
    expect_raises( ArgumentError, "FenwickTree#add: index 0 must not be zero or negative" ) { bit[0] = 1 }
    expect_raises( ArgumentError, "FenwickTree#add: index -1 must not be zero or negative" ) { bit[-1] = 1 }
  end

  it "solve Chokudai Speed Run 001 J" do
    cases = [
      { 5, [3,1,5,4,2] , 5 },
      { 6, [1,2,3,4,5,6] , 0 },
      { 7, [7,6,5,4,3,2,1] , 21 },
      { 20, [19,11,10,7,8,9,17,18,20,4,3,15,16,1,5,14,6,2,13,12],114}
    ]
    cases.each do |(n,a,ans)|
      inversion_number(a).should eq ans
      # ChokudaiSpeedRun001J.new(n,a).solve.should eq ans
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
