require "crystal/graph"

struct Dag
  getter g : Graph
  delegate n, to: g

  def initialize(@g)
  end

  def solve
    Graph.new(n).tap do |gg|
      n.times do |v|
        g[v].each do |nv|
          next unless v < nv
          gg.add v, nv, both: false, origin: 0
        end
      end
    end
  end
end
