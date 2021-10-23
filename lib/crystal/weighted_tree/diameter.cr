require "crystal/weighted_tree/depth"
require "crystal/weighted_tree/parent"

module WeightedTree
  class Diameter
    getter g : Tree
    delegate n, to: g

    def initialize(@g)
    end

    def solve
      # 任意の一つの点の最遠点aを求める
      depth_one = Depth.new(g).solve(0)
      a = n.times.max_by do |v|
        depth_one[v]
      end
  
      # aの最遠点bを求める。パスa-bが直径
      depth_two = Depth.new(g).solve(a)
      b = n.times.max_by do |v|
        depth_two[v]
      end
  
      # bを根とした親の一覧を作る
      parent = Parent.new(g).solve(b)
  
      # 復元
      ans = [a]
      while ans[-1] != b
        ans << parent[ans[-1]]
      end
      ans.reverse
    end
  end
end
