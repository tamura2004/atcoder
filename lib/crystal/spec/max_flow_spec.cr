require "spec"
require "../max_flow"

describe Graph do
  it "usage" do
    g = Graph.new(8)
    g.add_edge(0, 1, 1)
    g.add_edge(0, 2, 1)
    g.add_edge(0, 3, 1)
    g.add_edge(1, 4, 1)
    g.add_edge(2, 4, 1)
    g.add_edge(3, 4, 1)
    g.add_edge(1, 5, 1)
    g.add_edge(1, 6, 1)
    g.add_edge(4, 7, 1)
    g.add_edge(6, 7, 1)
    g.add_edge(6, 7, 1)
    g.flow(0, 7).should eq 2
  end
end

describe Graph do
  it "usage weighted" do
    g = Graph.new(5)
    g.add_edge(0, 1, 10_i64)
    g.add_edge(0, 2, 2_i64)
    g.add_edge(1, 2, 6_i64)
    g.add_edge(1, 3, 6_i64)
    g.add_edge(3, 2, 3_i64)
    g.add_edge(2, 4, 5_i64)
    g.add_edge(3, 4, 8_i64)
    g.flow(0, 4).should eq 11
  end
end

# https://atcoder.jp/contests/abc010/tasks/abc010_4
describe ABC010D do
  it "solve problem" do
    ABC010D.new(4,2,3,[2,3],[{0,1},{1,2},{1,3}]).solve.should eq 1
    ABC010D.new(4,1,4,[3],[{0,1},{0,2},{1,3},{2,3}]).solve.should eq 1
    ABC010D.new(10,3,11,[7,8,9],[{0,1},{0,2},{0,3},{0,4},{1,5},{2,5},{5,6},{6,7},{6,8},{3,9},{4,9}]).solve.should eq 2
  end
end

class ABC010D
  SINK = 100
  getter n : Int32
  getter g : Int32
  getter e : Int32
  getter flow : Graph

  def initialize(@n,@g,@e,girl,ab)
    @flow = Graph.new(101)
    ab.each do |(a,b)|
      flow.add_edge(a,b,1)
      flow.add_edge(b,a,1)
    end
    girl.each do |i|
      flow.add_edge(i,SINK,1)
    end
  end

  def solve
    flow.flow(0,SINK)
  end
end