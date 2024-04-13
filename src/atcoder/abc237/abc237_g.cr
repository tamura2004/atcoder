require "crystal/lst"

class Problem
  getter n : Int64
  getter q : Int64
  getter x : Int64
  getter a : Array(Int64)
  getter qs : Array(Tuple(Int64,Int64,Int64))
  getter lst : LST::RangeUpdateRangeSum

  def initialize(@n, @q, @x, @a, @qs)
    @lst = LST.range_update_range_sum(a)
  end

  def self.read
    n, q, x = gets.to_s.split.map(&.to_i64)
    a = gets.to_s.split.map(&.to_i64)
    qs = Array.new(q) {
      c, l, r = gets.to_s.split.map(&.to_i64)
      {c, l, r}
    }
    new(n, q, x, a, qs)
  end

  def solve
  end

  def run
    pp! self
    puts solve
  end
end

Problem.read.run
