require "spec"
require "../mod_pow"

describe "mod_pow" do
  it "usage" do
    n = 10_i64
    m = 10_i64 ** 18
    mod = 10_i64 ** 9 + 7
    mod_pow(n,m,mod).should eq 2401
  end

  it "solve arc111a" do
    ARC111_A.new(10_i64**18, 9997_i64).solve.should eq 9015
  end
end

class ARC111_A
  getter n : Int64
  getter m : Int64

  def initialize(@n,@m)
  end

  def solve
    mod_pow(10_i64, n, m ** 2) // m
  end
end
