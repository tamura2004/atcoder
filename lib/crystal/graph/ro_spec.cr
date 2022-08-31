require "spec"
require "crystal/graph"
require "crystal/graph/ro"

describe Ro do
  # [1] -> [2] -> [3] -> [4] -> [5]
  #  ^                           |
  #  +---------------------------+
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2, both: false
    g.add 2, 3, both: false
    g.add 3, 4, both: false
    g.add 4, 5, both: false
    g.add 5, 1, both: false

    ro = Ro.new(g).solve(7)
    ro.goal.should eq 2
    ro.n.should eq 5
    ro.m.should eq 0
    ro.path.should eq [0, 1, 2, 3, 4]
    ro.hist.should eq [2, 2, 2, 1, 1]
  end

  # [1] -> [2] -> [3] -> [4] -> [5]
  #                ^             |
  #                +-------------+
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2, both: false
    g.add 2, 3, both: false
    g.add 3, 4, both: false
    g.add 4, 5, both: false
    g.add 5, 3, both: false

    ro = Ro.new(g).solve(9)
    ro.goal.should eq 3
    ro.n.should eq 5
    ro.m.should eq 2
    ro.path.should eq [0, 1, 2, 3, 4]
    ro.hist.should eq [1, 1, 3, 3, 2]
  end

  # [1] -> [2] -> [3] -> [4] -> [5]
  #                ^             |
  #                +-------------+
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2, both: false
    g.add 2, 3, both: false
    g.add 3, 4, both: false
    g.add 4, 5, both: false
    g.add 5, 3, both: false

    ro = Ro.new(g).solve(0)
    ro.goal.should eq 0
    ro.n.should eq 5
    ro.m.should eq 2
    ro.path.should eq [0, 1, 2, 3, 4]
    ro.hist.should eq [1]
  end

  # [1] -> [2] -> [3] -> [4] -> [5]
  #                ^             |
  #                +-------------+
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2, both: false
    g.add 2, 3, both: false
    g.add 3, 4, both: false
    g.add 4, 5, both: false
    g.add 5, 3, both: false

    ro = Ro.new(g).solve(1)
    ro.goal.should eq 1
    ro.n.should eq 5
    ro.m.should eq 2
    ro.path.should eq [0, 1, 2, 3, 4]
    ro.hist.should eq [1, 1]
  end

  # [1] -> [2] -> [3] -> [4] -> [5] <-
  #                              |   |
  #                              +---+
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2, both: false
    g.add 2, 3, both: false
    g.add 3, 4, both: false
    g.add 4, 5, both: false
    g.add 5, 5, both: false

    ro = Ro.new(g).solve(9)
    ro.goal.should eq 4
    ro.n.should eq 5
    ro.m.should eq 4
    ro.path.should eq [0, 1, 2, 3, 4]
    ro.hist.should eq [1, 1, 1, 1, 6]
  end

  # [1] -> [2] -> [3] -> [4] -> [5] <-
  #                              |   |
  #                              +---+
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2, both: false
    g.add 2, 3, both: false
    g.add 3, 4, both: false
    g.add 4, 5, both: false
    g.add 5, 5, both: false

    ro = Ro.new(g).solve(2)
    ro.goal.should eq 2
    ro.n.should eq 5
    ro.m.should eq 4
    ro.path.should eq [0, 1, 2, 3, 4]
    ro.hist.should eq [1, 1, 1]
  end
end
