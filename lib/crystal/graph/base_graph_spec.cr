require "spec"
require "crystal/graph/base_graph"
require "crystal/graph/dijkstra"

alias V = Tuple(Int32,Int32)

def early_return(g)
  ans = [] of Int32
  g.each do |v|
    ans << v
    return ans if v == 1
  end
end

describe BaseGraph do
  it "usage" do
    g = BaseGraph(Int32).new(3)
    g.add 1, 2
    g.add 2, 3
    Dijkstra.new(g).solve.should eq [0,1,2]
  end
  
  it "iterate" do
    g = BaseGraph(Int32).new(6)
    g.add 1, 2
    g.add 2, 3
    g.add 3, 4
    g.add 4, 5
    g.add 5, 6
    g.add 6, 1
    dep = Dijkstra.new(g).solve(0)
    g.each.max_by{|v|dep[v]}.should eq 3 
  end

  it "cost" do
    g = BaseGraph(Tuple(Int32,Int32)).new
    g.add ({1,1}), ({2,2}), 100_i64
    g.add ({3,3}), ({2,2}), 200_i64
    Dijkstra.new(g).solve.should eq [0,100,300]
  end

  it "breakable" do
    g = BaseGraph(Int32).new(4)
    got = [] of Int32
    g.each do |v|
      got << v
      break if v == 1
    end
    got.should eq [0,1]
  end

  it "early return" do
    g = BaseGraph(Int32).new(4)
    ans = early_return(g)
    ans.should eq [0,1]
  end
end
