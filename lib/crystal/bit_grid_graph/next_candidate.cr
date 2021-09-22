require "crystal/bit_grid_graph/graph"

module BitGridGraph
  struct NextCandidate
    getter g : Graph
    delegate each, ix, h, w, to: g

    def initialize(@g)
    end

    def solve
      each do |y, x|
        next if g[y, x] == 1 # 黒く塗る候補
        each(y, x) do |ny, nx|
          if g[ny, nx] == 1
            yield Graph.new h, w, g | 1_i64 << ix(y, x)
            break
          end
        end
      end
    end
  end
end
