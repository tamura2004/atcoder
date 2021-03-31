require "spec"
require "crystal/priority_queue"
require "../dijkstra"

describe Dijkstra do
  it "usage" do
    # [1] -2-> [2]
    #  | \      |
    #  7   3    2
    #  |     \  |
    #  V      v V
    # [4] <-2- [3]
    g = Dijkstra.new(4)
    g.add "1 2 2"
    g.add "2 3 2"
    g.add "1 3 3"
    g.add "3 4 2"
    g.add "1 4 7"
    g.solve(0).should eq [0, 2, 3, 5]
  end

  it "solve arc109a" do
    ARC109A.read("2 1 1 5").solve.should eq 1
    ARC109A.read("1 2 100 1").solve.should eq 101
    ARC109A.read("1 100 1 100").solve.should eq 199
  end

  it "solve abc035d case 1" do
    input = IO::Memory.new <<-EOD
    8 15 120
    1 2 6 16 1 3 11 9
    1 8 1
    7 3 14
    8 2 13
    3 5 4
    5 7 5
    6 4 1
    6 8 17
    7 8 5
    1 4 2
    4 7 1
    6 1 3
    3 1 10
    2 6 5
    2 4 12
    5 1 30
    EOD
    ABC035D.read(input).solve.should eq 1488
  end
end

class ARC109A
  getter a : Int32
  getter b : Int32
  getter x : Int32
  getter y : Int32

  def self.read(io : IO)
    a, b, x, y = io.gets.to_s.split.map(&.to_i)
    new(a, b, x, y)
  end

  def self.read
    read(STDIN)
  end
  
  def self.read(input : String)
    read(IO::Memory.new(input))
  end

  def initialize(@a, @b, @x, @y)
  end

  def solve
    g = Dijkstra.new(200)

    # 水平な廊下
    100.times do |i|
      j = i + 100
      g.add i, j, x.to_i64, both: true
    end

    # 斜めの廊下と縦の階段
    99.times do |i|
      j = i + 100
      g.add i + 1, j, x.to_i64, both: true
      g.add i, i + 1, y.to_i64, both: true
      g.add j, j + 1, y.to_i64, both: true
    end

    g.solve(a - 1)[100 + b - 1]
  end
end

class ABC035D
  getter n : Int32
  getter m : Int32
  getter t : Int32
  getter a : Array(Int64)
  getter g : Dijkstra
  getter r : Dijkstra

  def self.read(io : IO::Memory)
    n, m, t = io.gets.to_s.split.map { |v| v.to_i }
    a = io.gets.to_s.split.map { |v| v.to_i64 }
    g = Dijkstra.new(n)
    m.times do
      # i, j, cost = io.gets.to_s.split.map { |v| v.to_i64 }
      g.add io.gets.to_s
    end
    new(n, m, t, a, g)
  end

  def initialize(@n, @m, @t, @a, @g)
    @r = g.reverse
  end

  def solve
    go = g.solve(0)
    back = r.solve(0)

    ans = 0_i64
    n.times do |i|
      cnt = t - go[i] - back[i]
      next if cnt <= 0
      ans = Math.max ans, cnt * a[i]
    end
    return ans
  end
end
