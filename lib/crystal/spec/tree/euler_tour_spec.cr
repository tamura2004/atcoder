require "spec"
require "crystal/tree/euler_tour.cr"

module Tree
  describe EulerTour do
    it "usage" do
      g = Tree.new(5)
      g.add 1, 2
      g.add 1, 3
      g.add 2, 4
      g.add 2, 5
      enter, leave, index = EulerTour.new(g).solve
      enter.should eq [0, 1, 7, 2, 4]
      leave.should eq [9, 6, 8, 3, 5]
      index.should eq [0, 1, 3, -4, 4, -5, -2, 2, -3, -1]
    end
  end
end
