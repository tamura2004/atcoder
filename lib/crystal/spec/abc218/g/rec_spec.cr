require "spec"
require "crystal/abc218/g/rec"
include Abc218::G

describe Abc218::G::Rec do
  it "init" do
    t = Tree.new(5)
    t.add 4, 5
    t.add 3, 4
    t.add 1, 5
    t.add 2, 4
    a = [2, 4, 6, 8, 10].map(&.to_i64)
    r = Rec.new(t, a)
    r.solve.should eq [2, 6, 7, 8, 6]
  end
end
