require "crystal/graph"

struct ReverseGraph
  getter g : Graph
  delegate n, to: g

  def initialize(@g)
  end

  def solve
    ans = Graph.new(n)

    n.times do |v|
      g[v].each do |nv|
        ans.add nv, v, origin: 0, both: false
      end
    end

    return ans
  end
end
