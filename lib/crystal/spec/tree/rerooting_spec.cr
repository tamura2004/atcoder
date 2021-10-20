require "spec"
require "crystal/tree/rerooting"

alias V = Int32
alias T = Int64

describe Rerooting do
  it "usage" do
    g = Tree.new(3)
    g.add 1, 2
    g.add 2, 3
    m = 100

    rr = Rerooting(T).new(
      g,
      merge: ->(a : T, b : T) { (a * b) % m },
      apply: ->(a : T, v : V) { (a + 1) % m },
      unit: 1_i64
    )
    rr.solve.should eq [3, 4, 3]
  end
end
