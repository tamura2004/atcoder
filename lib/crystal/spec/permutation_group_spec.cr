require "spec"
require "../permutation_group"

describe PermutationGroup do
  it "usage" do
    a = [1,2,0,3]
    pg = PermutationGroup.new(a)
    pg.inv.should eq [2,0,1,3]
    pg.fixed?(0).should eq false
    pg.fixed?(3).should eq true
    pg.swap(0,2)
    pg.a.should eq [0,2,1,3]
    pg.inv.should eq [0,2,1,3]
  end

  it "solve arc111c too heavy" do
    n = 4
    a = [1,2,3,4]
    b = [4,3,2,1]
    p = [3,2,1,0]
    ARC111C_TOO_HEAVY.new(n,a,b,p).solve.should eq -1
  end
end

class ARC111C_TOO_HEAVY
  getter n : Int32
  getter a : Array(Int32)
  getter b : Array(Int32)
  getter p : Array(Int32)

  def initialize(@n,@a,@b,@p)
  end

  def solve
    pg = PG.new(p)

    flag = n.times.any? do |i|
      !pg.fixed?(i) && a[i] <= b[pg.a[i]]
    end

    if flag
      puts -1
      exit
    end

    ans = [] of Tuple(Int32,Int32)
    a.zip(0..).sort.each do |w,i|
      next if pg.fixed?(i)
      j = pg.inv[i]
      pg.swap(i,j)
      ans << {i,j}
    end

    return ans
  end
end
