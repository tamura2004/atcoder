class Problem
  getter n : Int32
  getter m : Int32
  getter a : Array(Int32)

  def initialize(@n,@m,@a)
  end

  def self.read
    n,m = gets.to_s.split.map(&.to_i64)
    a = Array.new(n){gets.to_s.to_i64}
    new(n,m,a)
  end

  def solve
  end
end
