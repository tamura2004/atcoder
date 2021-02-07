require "spec"
require "crystal/priority_queue"
require "../dijkstra"

describe Graph do
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

class ABC035D
  getter n : Int32
  getter m : Int32
  getter t : Int32
  getter a : Array(Int64)
  getter g : Graph
  getter r : Graph

  def self.read(io : IO::Memory)
    n,m,t = io.gets.to_s.split.map { |v| v.to_i }
    a = io.gets.to_s.split.map { |v| v.to_i64 }
    g = Graph.new(n)
    m.times do
      i,j,cost = io.gets.to_s.split.map { |v| v.to_i64 }
      g.add_edge(i,j,cost)
    end
    new(n,m,t,a,g)
  end

  def initialize(@n,@m,@t,@a,@g)
    @r = g.reverse
  end

  def solve
    go = g.dijkstra(0)
    back = r.dijkstra(0)

    ans = 0_i64
    n.times do |i|
      cnt = t - go[i] - back[i]
      next if cnt <= 0
      ans = Math.max ans, cnt * a[i]
    end
    return ans
  end
end
