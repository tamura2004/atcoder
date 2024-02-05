require "crystal/indexable"

class RangeSum
  getter n : Int32
  getter a : Array(Int64)
  getter cs : Array(Int64)

  def initialize(@a)
    @n = @a.size
    @a.sort!
    @cs = @a.cs(head: false)
  end

  def sum_lower(limit : Int64)
    i = @a.bsearch_index(&.> limit)
    if i > 0
      @cs[i - 1]
    else
      0_i64
    end
  end
end
