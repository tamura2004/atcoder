require "crystal/graph/dag"

class Triangle
  getter g : Graph
  delegate n, to: g

  def initialize(g)
    @g = Dag.new(g).solve
  end

  def solve
    Array(Tuple(Int32,Int32,Int32)).new.tap do |ans|
      n.times do |v|
        g[v].each do |nv|
          (g[v] & g[nv]).each do |k|
            ans << {v, nv, k}
          end
        end
      end
    end
  end
end
