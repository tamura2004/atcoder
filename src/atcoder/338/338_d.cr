# 区間加算、区間最小
# require "crystal/lazy_segment_tree"
require "crystal/lst"

class Problem
  getter n : Int64
  getter m : Int64
  getter x : Array(Int32)
  # getter st : LazySegmentTree(Int64, Int64)
  getter st : LST(Int64, Int64)
  getter ans : Int64

  def initialize(@n,@m,@x)
    # @st = LazySegmentTree(Int64, Int64).range_add_range_min(Array.new(n, 0_i64))
    @st = LST.new(
      n: @n,
      fxx: Proc(Int64,Int64,Int64).new{|x,y| Math.min(x, y) },
      fxa: Proc(Int64,Int64,Int64).new{|x,a| x + a},
      faa: Proc(Int64,Int64,Int64).new{|a,b| a + b},
    )
    @n.times do |i|
      @st[i] = 0_i64
    end
    @ans = 0_i64
  end

  def self.read
    n, m = gets.to_s.split.map(&.to_i64)
    x = gets.to_s.split.map(&.to_i.pred)
    new(n,m,x)
  end

  def solve
    x.each_cons_pair do |i, j|
      q(i, j)
      # pp ans
      # pp (0...n).map{|i|st[i..i]}
    end
    ans + (st.query(0, n-1) || 0)
  end

  def q(i, j)
    i, j = j, i unless i < j
    inner = j - i
    outer = n + i - j

    if inner < outer
      @ans += inner
      # pp! [0,i,j,outer,inner]
      st[i...j] = outer - inner
      #
    elsif inner > outer
      @ans += outer
      if i != 0
        # pp! [1,i,j,outer,inner]
        st[...i] = inner - outer
      end
      # pp! [2,i,j,outer,inner]
      if j != n - 1
        # pp! [2,i,j,outer,inner]
        st[j..] = inner - outer
      end
      #
    else
      @ans += inner
    end
  end
end

pp Problem.read.solve