require "spec"
require "crystal/tree/hl_sort"

describe HLSort do
  it "usage" do
    g = Tree.new(4)
    g.add 1, 2, both: false
    g.add 1, 3, both: false
    g.add 3, 4, both: false
    g.g.should eq [[1, 2], [] of Int32, [3], [] of Int32]
    HLSort.new(g).sort!
    g.g.should eq [[2, 1], [] of Int32, [3], [] of Int32]
  end
end
