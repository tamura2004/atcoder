require "spec"
require "crystal/graph"
require "crystal/graph/tsort.cr"

describe Tsort do
  it "トポロジカルソート" do
    g = Graph.new(4)
    g.add 2, 1, both: false
    g.add 3, 1, both: false
    g.add 4, 2, both: false
    g.add 4, 3, both: false
    Tsort.new(g).solve?.should eq [3, 1, 2, 0]
    Tsort.new(g).has_loop?.should eq false
  end

  it "トポロジカルソート" do
    g = Graph.new(4)
    g.add 1, 2, both: false
    g.add 3, 4, both: false
    Tsort.new(g).solve?.should eq [0, 2, 1, 3]
    Tsort.new(g).has_loop?.should eq false
  end

  it "閉路を持つためソート不能" do
    g = Graph.new(4)
    g.add 1, 2, both: false
    g.add 2, 3, both: false
    g.add 3, 1, both: false
    Tsort.new(g).solve?.should eq nil
    Tsort.new(g).has_loop?.should eq true
  end

  it "ペアグラフ トポロジカルソート" do
    g = BaseGraph(Tuple(Int32,Int32)).new
    g.add ({1, 10}), ({2, 20}), both: false
    g.add ({3, 30}), ({4, 40}), both: false
    Tsort.new(g).solve?.should eq [0, 2, 1, 3]
    Tsort.new(g).has_loop?.should eq false
  end

  it "ペアグラフ 閉路を持つためソート不能" do
    g = BaseGraph(Tuple(Int32,Int32)).new
    g.add ({1, 10}), ({2, 20}), both: false
    g.add ({2, 20}), ({3, 30}), both: false
    g.add ({3, 30}), ({1, 10}), both: false
    Tsort.new(g).solve?.should eq nil
    Tsort.new(g).has_loop?.should eq true
  end
end
