require "crystal/problem"
require "crystal/largest_rectangle_in_a_histgram"

class Main < Problem
  getter n : Int32
  getter a : Array(Int64)

  def initialize(@n, @a)
  end

  def self.read(io : IO)
    n = io.gets.to_s.to_i
    a = io.gets.to_s.split.map(&.to_i64)
    new(n, a)
  end

  def solve
    LargestRectanbleInAHistgram.new(n,a).solve
  end

  def run
    pp! self
    puts solve
  end
end

Main.read("7\n7 6 5 4 3 2 1").run # => 16