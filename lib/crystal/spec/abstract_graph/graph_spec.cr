require "spec"
require "crystal/abstract_graph/graph"

record VR, i : Int32

struct VS
  getter i : Int32

  def initialize(@i)
  end
end

describe Graph do
  it "タプルを頂点に持つ" do
    g = Graph(Tuple(Int32, Int32)).new
    g.add ({1, 2}), ({1, 3})
    g.add ({1, 2}), ({1, 4})
    g[{1, 2}].should eq [{1, 3}, {1, 4}]
    puts g
  end
  
  it "レコードを頂点に持つ" do
    g = Graph(VR).new
    g.add VR.new(1), VR.new(2)
    g.add VR.new(1), VR.new(3)
    g[VR.new(1)].should eq [VR.new(2),VR.new(3)]
    puts g
  end
  
  it "構造体を頂点に持つ" do
    g = Graph(VS).new
    g.add VS.new(1), VS.new(2)
    g.add VS.new(1), VS.new(3)
    g[VS.new(1)].should eq [VS.new(2),VS.new(3)]
    puts g
  end
end
