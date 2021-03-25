require "spec"
require "../ro"

describe Ro do
  it "ループの開始点と終了点を求める" do
    i = 0
    a = [1,2,3,4,5,6,4]
    ro = Ro(Int32,Int32).new do
      i += 1
      a[i]
    end
    lo, hi = ro.rec(0)
    lo.should eq 3
    hi.should eq 6
  end

  it "初期状態*x*に対し*k*回*f*を適用した時の値を求める, k < lo" do
    i = 0
    a = [1,2,3,4,5,6,4]
    ro = Ro(Int32,Int32).new do
      i += 1
      a[i]
    end
    ro.solve(0,2).should eq 3
    ro.solve(0,333333).should eq 4
    ro.idx.clear
    ro.val.clear
  end

  it "初期状態*x*に対し*k*回*f*を適用した時の値を求める" do
    i = 0
    a = [1,2,3,4,5,6,4]
    ro = Ro(Int32,Int32).new do
      i += 1
      a[i]
    end
    ro.solve(0,333333).should eq 4
  end
end
