require "spec"
require "crystal/graph"
require "crystal/graph/depth"
require "crystal/graph/dijkstra"
require "crystal/graph/bellman_ford"
require "crystal/graph/deg"
require "crystal/graph/in_deg"

describe Graph do
  it "usage" do
    g = Graph.new(3)
    g.add 1, 2
    g.add 2, 3

    a = [] of Int32
    g.each do |v|
      a << v
    end
    a.should eq [0, 1, 2]
  end

  it "depth" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 4, 1
    g.add 4, 2
    g.add 3, 2
    Depth.new(g).solve.should eq [0, 1, 2, 1]
  end

  it "dijkstra" do
    g = Graph.new(4)
    g.add 1, 2, 4
    g.add 4, 1, 10
    g.add 4, 2, 20
    g.add 3, 2, 3
    Dijkstra.new(g).solve.should eq [0, 4, 7, 10]
  end

  it "bellman_ford" do
    g = Graph.new(4)
    g.add 1, 2, 4
    g.add 4, 1, 10
    g.add 4, 2, 20
    g.add 3, 2, 3
    depth, neg = BellmanFord.new(g).solve
    depth.should eq [0,4,7,10]
    neg.should eq [false,false,false,false]
  end

  it "bellman_ford with neg loop" do
    g = Graph.new(4)
    g.add 1, 2, 10, both: false
    g.add 2, 3, 20, both: false
    g.add 3, 4, 30, both: false
    g.add 4, 3, -40, both: false
    depth, neg = BellmanFord.new(g).solve
    depth.should eq [0,10,-10,30]
    neg.should eq [false,false,true,true]
  end
  
  it "deg both" do
    g = Graph.new(4)
    g.add 1, 4, 10, both: true
    g.add 4, 2, -20, both: true
    g.add 2, 1, 30, both: true
    g.add 2, 3, 3, both: true
    Deg.new(g).solve.should eq [2,3,1,2]
  end
  
  it "deg" do
    g = Graph.new(4)
    g.add 1, 4, 10, both: false
    g.add 4, 2, -20, both: false
    g.add 2, 1, 30, both: false
    g.add 2, 3, 3, both: false
    Deg.new(g).solve.should eq [1,2,0,1]
  end
  
  it "in_deg" do
    g = Graph.new(4)
    g.add 1, 4, 10, both: false
    g.add 4, 2, -20, both: false
    g.add 2, 1, 30, both: false
    g.add 2, 3, 3, both: false
    InDeg.new(g).solve.should eq [1,1,1,1]
  end
end
