require "spec"
require "crystal/graph/dfs"
require "crystal/graph/graph"

describe Dfs do
  it "in order tree" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 2, 3
    g.add 2, 4
    ans = [] of Tuple(Int32,Int32)
    Dfs.new(g).dfs(0) do |ev, v, nv|
      case ev
      when .before?
        ans << {v, nv}
      end
    end
    ans.should eq [{0,1},{1,2},{1,3}]

  end

  it "in order graph" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 2, 3
    g.add 2, 4
    g.add 3, 4
    ans = [] of Tuple(Int32,Int32)
    Dfs.new(g).dfs(0) do |ev, v, nv|
      case ev
      when .before?
        ans << {v, nv}
      end
    end
    ans.should eq [{0,1},{1,2},{2,3}]

  end

  it "out order tree" do
    g = Graph.new(4)
    g.add 1, 2
    g.add 2, 3
    g.add 2, 4
    ans = [] of Tuple(Int32,Int32)
    Dfs.new(g).dfs(0) do |ev, v, nv|
      case ev
      when .after?
        ans << {v, nv}
      end
    end
    ans.should eq [{1,2},{1,3},{0,1}]
  end
end
