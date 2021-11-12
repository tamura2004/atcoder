module GridGraph
  class Graph
    DIR = [{-1,0},{1,0},{0,1},{0,-1}]

    getter h : Int32
    getter w : Int32

    def initialize(@h,@w)
    end

    def each(y, x)
      DIR.each do |dy, dx|
        ny = y + dy
        nx = x + dx
        next if outside?(ny, nx)
        yield ny, nx
      end
    end

    def each(i)
      y, x = from_ix(i)
      each(y, x) do |ny, nx|
        j = to_ix(ny, nx)
        yield j
      end
    end

    def outside?(y, x)
      y < 0 || h <= y || x < 0 || w <= x
    end

    def to_ix(y, x)
      y * w + x
    end

    def from_ix(i)
      i.divmod(w)
    end
  end
end
