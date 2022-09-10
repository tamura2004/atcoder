require "spec"
require "crystal/graph"
require "crystal/graph/rerooting"

describe Rerooting do
  it "usage" do
    g = Graph.new([-1, 1, 2, 3, 4])

    f1 = ->(a : Bool) { a }
    merge = ->(a : Bool, b : Bool) { a || b }
    unit = false
    f2 = ->(a : Bool) { !a }

    rr = Rerooting(Bool).new(g, f1, merge, unit, f2)
    rr.solve.should eq [true, false, true, false, true]
  end

  it "usage 2" do
    g = Graph.new([1, 2, 3, [4, 5], [6, 7, 8]])
    f1 = -> (a : Int32) { a }
    merge = -> (a : Int32, b : Int32) { a + b }
    unit = 0
    f2 = -> (a : Int32) { a + 1 }
    rr = Rerooting(Int32).new(g, f1, merge, unit, f2)
    rr.solve
    pp rr.dp
  end
end
