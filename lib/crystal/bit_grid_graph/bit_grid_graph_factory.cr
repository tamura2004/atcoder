require "crystal/bit_grid_graph/graph"

module BitGridGraph
  class BitGridGraphFactory
    getter h : Int32
    getter w : Int32
    getter lefts : Array(Graph)
    getter rights : Array(Graph)

    def initialize(@h, @w)
      @lefts = Array.new(w) do |x|
        g = Graph.new(h, w)
        0.upto(x) do |x|
          h.times do |y|
            g[y,x] = 1
          end
        end
        g
      end

      @rights = Array.new(w) do |x|
        g = Graph.new(h, w)
        (w-1-x).upto(w-1) do |xx|
          h.times do |y|
            g[y,xx] = 1
          end
        end
        g
      end
    end

    def zero
      Graph.new(h, w)
    end

    def up(g, k)
      Graph.new(h, w, g >> w * k)
    end

    def left(g, k)
      Graph.new h, w, g.g >> k & ~(rights[k-1].g)
    end

    def right(g, k)
      Graph.new h, w, g.g << k & ~(lefts[k-1].g)
    end
  end
end
