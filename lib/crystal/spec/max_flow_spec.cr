require "spec"
require "../max_flow"

describe MaxFlow do
  it "return max flow" do
    g = MaxFlow(Int64).new(5)
    g.add_edge(0, 1, 10_i64)
    g.add_edge(0, 2, 2_i64)
    g.add_edge(1, 2, 6_i64)
    g.add_edge(1, 3, 6_i64)
    g.add_edge(3, 2, 3_i64)
    g.add_edge(2, 4, 5_i64)
    g.add_edge(3, 4, 8_i64)
    g.max_flow(0, 4).should eq 11
  end
end
