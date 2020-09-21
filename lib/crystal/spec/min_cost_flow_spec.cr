require "spec"
require "../min_cost_flow"

describe MinCostFlow do
  it "usage" do
    edges = {
      {from: 0, to: 1, cap: 1, cost: 100},
      {from: 0, to: 2, cap: 2, cost: 200},
      {from: 1, to: 3, cap: 3, cost: 300},
      {from: 2, to: 3, cap: 4, cost: 400},
    }
    g = MinCostFlow.new(4)
    edges.each do |e|
      g.add_edge(e[:from], e[:to], e[:cap], e[:cost])
    end
    g.min_cost_flow(0,3,3).should eq 1600
    # 0 -> 1 -> 3 * 1 = (100 + 300) * 1 =  400
    # 0 -> 2 -> 3 * 2 = (200 + 400) * 2 = 1200
  end
  
  it "returns min cost flow" do
    ABC004D.new(2, 3, 4).solve.should eq 7
    ABC004D.new(17, 2, 34).solve.should eq 362
    ABC004D.new(267, 294, 165).solve.should eq 88577
    ABC004D.new(300, 300, 300).solve.should eq 142500
  end
end

# https://atcoder.jp/contests/abc004/tasks/abc004_4
class ABC004D
  getter x : Int32
  getter y : Int32
  getter z : Int32
  getter n : Int32
  getter g : MinCostFlow

  def initialize(@x, @y, @z)
    @n = 1001 # x := n - 500 [-460,460]
    @g = MinCostFlow.new(n)
  end

  def add_edge_from_origin
    g.add_edge(0, 400, x, 0)
    g.add_edge(0, 500, y, 0)
    g.add_edge(0, 600, z, 0)
  end

  def add_edge_to_sink
    40.upto(960) do |i|
      g.add_edge(i, 1000, 1, 0)
    end
  end

  def add_edge_from_post
    [400, 500, 600].each do |i|
      40.upto(960) do |j|
        cost = (i - j).abs
        g.add_edge(i, j, 1, cost)
      end
    end
  end

  def solve
    add_edge_from_origin
    add_edge_to_sink
    add_edge_from_post
    g.min_cost_flow(0, 1000, x + y + z)
  end
end