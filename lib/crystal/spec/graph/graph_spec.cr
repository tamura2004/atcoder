require "spec"
require "crystal/graph"

describe Graph do
  it "usage" do
    g = Graph.new(3)
    g.add 1, 2
    g.add 2, 3

    a = [] of Int32
    g.each do |v|
      a << v
    end
    a.should eq [0,1,2]
  end
end