require "big"

class Problem
  N = 10000_i64
  getter x : Int64
  getter y : Int64
  getter r : Int64

  def self.read
    x, y, r = gets.to_s.split.map(&.to_big_d.*(N).floor.to_i64)
    new(x, y, r)
  end

  def initialize(@x, @y, @r)
  end

  def solve
    bottom.upto(top).sum do |i|
      ii = i * N
      lo = left(ii).to_i64
      hi = right(ii).to_i64
      calc(lo, hi, N)
    end
  end

  def left(i) # 中の点
    ((x - r)..x).bsearch do |j|
      (j - x) ** 2 + (i - y) ** 2 <= r ** 2
    end.not_nil!
  end

  def right(i) # 外の点
    (x..(x + r + 1)).bsearch do |j|
      (j - x) ** 2 + (i - y) ** 2 > r ** 2
    end.not_nil!
  end

  def calc(a, b, c)
    (b - 1)//c - (a - 1)//c
  end

  def bottom
    div_ceil(y - r, N)
  end

  def top
    (y + r) // N
  end

  def div_ceil(a, b)
    (a + b - 1) // b
  end

  def run
    pp solve
  end
end

Problem.read.run
