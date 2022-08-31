require "spec"
require "crystal/graph/base_graph"
require "crystal/graph/dijkstra"

alias V = Tuple(Int32,Int32)
alias E1 = NamedTuple(cost: Int64, color: Int32)
record E2, cost : Int64, color : Int32

describe BaseGraph do
  it "usage" do
    g = BaseGraph(Int32,Nil).new(3)
    g.add 1, 2
    g.add 2, 3
    Dijkstra.new(g).solve.should eq [0,1,2]
  end

  it "cost" do
    g = BaseGraph(V,Int64).new
    g.add ({1,1}), ({2,2}), 100_i64
    g.add ({3,3}), ({2,2}), 200_i64
    Dijkstra.new(g).solve.should eq [0,100,300]
  end

  it "tuple" do
    g = BaseGraph(V,Tuple(Int64,Int32)).new
    g.add ({1,1}), ({2,2}), ({100_i64, 10})
    g.add ({3,3}), ({2,2}), ({200_i64, 20})
    Dijkstra.new(g).solve.should eq [0,100,300]
  end

  it "named tuple" do
    g = BaseGraph(V,E1).new
    g.add ({1,1}), ({2,2}), ({cost: 100_i64, color: 10})
    g.add ({3,3}), ({2,2}), ({cost: 200_i64, color: 20})
    Dijkstra.new(g).solve.should eq [0,100,300]
  end

  it "record" do
    g = BaseGraph(V,E2).new
    g.add ({1,1}), ({2,2}), E2.new(100_i64, 10)
    g.add ({3,3}), ({2,2}), E2.new(200_i64, 20)
    Dijkstra.new(g).solve.should eq [0,100,300]
  end

  it "breakable" do
    g = BaseGraph(Int32,Int64).new(4)
    got = [] of Int32
    g.each do |v|
      got << v
      break if v == 1
    end
    got.should eq [0,1]
  end


end
