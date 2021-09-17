module WaveletTree
  class Tree
    getter a : Array(Int32)
    getter nodes : Array(BitArray)

    def initialize(@a)
      @nodes = Array.new(16) { BitArray.new }
      dfs(a, 0, 3)
    end

    def dfs(a, i, k)
      return if k < 0

      left = [] of Int32
      right = [] of Int32

      nodes[i].size = a.size
      a.each_with_index do |v, j|
        nodes[i][j] = v.bit(k - 1)
        # pp! [i,j,v,k,v.bit(k),nodes[i]]

        if v.bit(k - 1) == 1
          left << v
        else
          right << v
        end
      end

      dfs(left, i * 2 + 1, k - 1)
      dfs(right, i * 2 + 2, k - 1)
    end
  end

  class BitArray
    getter a : Int64
    property size : Int32

    def initialize
      @a = 0_i64
      @size = 0
    end

    def rank(i)
      (a & ((1_i64 << i) - 1)).popcount
    end

    def select(k)
      (0...size).bsearch { |i| k < i + 1 - rank(i + 1) }
    end

    def []=(i, v)
      if v == 1
        @a = @a | (1_i64 << i)
      else
        @a = @a & ~(1_i64 << i)
      end
    end

    def inspect
      to_s
    end

    def to_s
      sprintf("%0#{size}b", a).reverse
    end
  end
end
