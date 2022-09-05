require "spec"
require "crystal/imos"

describe IMOS do
  it "usage" do
    imos = IMOS(Int32).new(10)
    imos.add(-10, 5, 1)
    imos.add(4, 100, 2)
    imos.add(3, 7, 4)
    imos.to_a.should eq [1, 1, 1, 5, 7, 7, 6, 6, 2, 2]
  end

  it "solve tokiomarine2020_c" do
    n = 5
    k = 1
    a = [1,0,0,1,0]
    want = [1,2,2,1,2]
    Tokiomarine2020C.new(n,k,a).solve.should eq want
  end

  it "solve abc035c" do
    n = 5
    q = [1,4,2,5,3,3,1,5].map(&.- 1).each_slice(2).to_a
    ABC035.new(n,q).solve.should eq "01010"
  end
end

# https://atcoder.jp/contests/tokiomarine2020/tasks/tokiomarine2020_c
class Tokiomarine2020C
  getter n : Int32
  getter k : Int32
  getter a : Array(Int32)

  def initialize(@n,@k,@a)
  end

  def solve
    k.times do
      b = IMOS(Int32).new(n)
      n.times do |i|
        lo = i - a[i]
        hi = i + a[i]
        b.add(lo, hi, 1)
      end
      @a = b.to_a
      return a if a.all? { |v| v == n }
    end
    return a
  end
end

# https://atcoder.jp/contests/abc035/tasks/abc035_c
class ABC035
  getter n : Int32
  getter q : Array(Array(Int32))

  def initialize(@n, @q)
  end

  def solve
    a = IMOS(Int32).new(n)
    q.each do |(lo, hi)|
      a.add(lo, hi, 1)
    end
    return a.to_a.map{|v|v.even? ? 0 : 1}.join
  end
end