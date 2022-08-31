require "spec"
require "crystal/graph/generic_vertex_edge_graph"
require "crystal/graph/dijkstra"

record Edge, color : Int32, cost : Int64 do
  include IWeightedEdge
end

describe GenericVertexEdgeGraph do
  it "dijkstra" do
    g = GenericVertexEdgeGraph(Tuple(Int32, Int32)).new
    g.add ({1, 10}), ({2, 20}), Edge.new(10, 100_i64)
    g.add ({3, 30}), ({2, 20}), Edge.new(20, 200_i64)
    Dijkstra.new(g).solve.should eq [0,100,300]
  end
end
