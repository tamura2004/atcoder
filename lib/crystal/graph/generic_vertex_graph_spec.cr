require "spec"
require "crystal/graph/generic_vertex_graph"

describe GenericVertexGraph do
  it "usage" do
    g = GenericVertexGraph(Tuple(Int32, Int32)).new
    g.add ({0, 0}), ({1, 1}), 100
    g.add ({1, 1}), ({2, 2}), 200

    ans = [] of Tuple(Int32, Int64)
    g.each_with_cost(1) do |nv, cost|
      ans << {nv, cost}
    end
    ans.should eq [{0, 100}, {2, 200}]
  end
end
