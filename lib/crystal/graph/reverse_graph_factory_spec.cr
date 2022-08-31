require "spec"
require "crystal/graph"
require "crystal/graph/reverse_graph_factory.cr"

describe ReverseGraphFactory do
  it "usage" do
    g = Graph.new(2)
    g.add 1, 2, both: false
    rg = ReverseGraphFactory.new(g).solve
    rg.each(1) do |nv|
      nv.should eq 0 
    end
  end
end
