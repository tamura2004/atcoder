require "spec"
require "crystal/tree/parent"

module Tree
  describe Parent do
    it "usage" do
      g = Tree.new(5)
      g.add 1, 2
      g.add 1, 3
      g.add 2, 4
      g.add 2, 5
      Parent.new(g).solve.should eq [-1, 0, 0, 1, 1]
    end
  end
end
