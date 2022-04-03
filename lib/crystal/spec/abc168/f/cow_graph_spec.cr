require "spec"
require "crystal/abc168/f/cow_graph"
include Abc168::F

describe Abc168::F::CowGraph do
  it "usage" do
    g = CowGraph.new(5,5)
    g.cut(1,1,DIR::Down)
    g.cut(2,3,DIR::Left)
    g.cut(2,1,DIR::Right)
    g.cut(3,1,DIR::Up)
    pp g
  end
end
