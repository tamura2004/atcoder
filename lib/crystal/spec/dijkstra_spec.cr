require "spec"
require "crystal/priority_queue"
require "../dijkstra"

describe Dijkstra do
  it "solve abc035d case 1" do
    n, m, t = 2, 2, 5
    a = [1_i64, 3_i64]
    g1 = [
      [Edge.new(1, 2_i64)],
      [Edge.new(0, 1_i64)],
    ]
    g2 = [
      [Edge.new(1, 1_i64)],
      [Edge.new(0, 2_i64)],
    ]
    ABC035D.new(n, m, t, a, g1, g2).solve.should eq 6
  end
end

macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

record Edge, to : Int32, cost : Int64

class ABC035D
  getter n : Int32
  getter m : Int32
  getter t : Int32
  getter a : Array(Int64)
  getter g1 : Dijkstra(Edge)
  getter g2 : Dijkstra(Edge)

  def initialize(@n, @m, @t, @a, g1, g2)
    @g1 = Dijkstra(Edge).new(g1)
    @g2 = Dijkstra(Edge).new(g2)
  end

  def solve
    go = g1.dijkstra(0)
    back = g2.dijkstra(0)

    ans = 0_i64
    n.times do |i|
      cnt = t - go[i] - back[i]
      next if cnt <= 0
      chmax ans, cnt * a[i]
    end
    return ans
  end
end
