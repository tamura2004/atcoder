require "spec"
require "crystal/bit_grid_graph/bit_grid_graph_factory"
include BitGridGraph

describe BitGridGraph::BitGridGraphFactory do
  it "usage" do
    ft = BitGridGraphFactory.new(4, 4)
    g = Graph.new([
      "1111",
      "0111",
      "0011",
      "0001",
    ])

    ft.rights[2].to_string_array.should eq [
      "0111",
      "0111",
      "0111",
      "0111",
    ]

    ft.lefts[2].to_string_array.should eq [
      "1110",
      "1110",
      "1110",
      "1110",
    ]

    ft.up(g, 2).to_string_array.should eq [
      "0011",
      "0001",
      "0000",
      "0000",
    ]

    ft.left(g, 2).to_string_array.should eq [
      "1100",
      "1100",
      "1100",
      "0100",
    ]

    ft.right(g, 2).to_string_array.should eq [
      "0011",
      "0001",
      "0000",
      "0000",
    ]
  end
end
