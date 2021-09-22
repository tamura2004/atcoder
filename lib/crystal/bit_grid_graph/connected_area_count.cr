require "crystal/union_find_tree"
require "crystal/bit_grid_graph/graph"

module BitGridGraph
  class Graph
    def each_with_outside(y, x)
      DIR[0, 4].each do |dy, dx|
        ny = y + dy
        nx = x + dx
        yield ny, nx, outside?(ny, nx)
      end
    end
  end

  # 同色の連結領域数
  # ただし、外部を白に囲まれているとする
  class ConnectedAreaCount
    getter g : Graph
    delegate h, w, each, ix, to: g

    def initialize(@g)
    end

    def solve
      uf = UnionFindTree.new(h * w + 1)
      each do |y, x|
        each_with_outside(y, x) do |ny, nx, outside|
          if outside
            uf.unite ix(y,x), n if g[y,x] == 0 # 外縁で白なら外部と連結
          else
            uf.unite ix(ny,nx), ix(y, x) if g[ny, nx] == g[y, x] # 隣接で同色なら連結
          end
        end
      end

      uf.gsize
    end
  end
end
