require "spec"
require "crystal/tree/rerooting"

alias V = Int32

describe Rerooting do
  it "usage" do
    g = Tree.new(3)
    g.add 1, 2
    g.add 2, 3

    rr = Rerooting(V).new(
      g,
      -> (a : V, v : V) { a + 1 },
      -> (a : V, b : V) { Math.max a, b },
      0,
      -> (a : V, v : V) { a },
    )
    pp rr.solve

  end
end
