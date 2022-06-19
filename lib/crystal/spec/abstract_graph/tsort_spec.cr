require "spec"
require "crystal/abstract_graph/tsort"

describe Tsort do
  it "トポロジカルソートを行う" do
    g = Graph(Int32).new
    g.add 1, 2
    g.add 2, 3
    g.add 4, 3
    Tsort(Int32).new(g).solve.should eq [1,4,2,3]
  end
  
  it "ループを検出する" do
    g = Graph(Int32).new
    g.add 1, 2
    g.add 2, 3
    g.add 3, 1
    Tsort(Int32).new(g).has_loop?.should eq nil
  end
  
  it "最長パスを求める" do
    g = Graph(Int32).new
    g.add 1, 2
    g.add 2, 3
    g.add 4, 3
    Tsort(Int32).new(g).longest_path.should eq ({ 1 => 0, 2 => 1, 3 => 2, 4 => 0})
  end
end
