require "crystal/lst"

class RangeUpdateRangeSum
  class X
    getter cnt : Int64
    getter sum : Int64

    def initialize(@sum, @cnt = 1_i64)
    end

    def +(b : self)
      self.class.new(sum + b.sum, cnt + b.cnt)
    end

    def *(b : Int64)
      self.class.new(b * cnt, cnt)
    end
  end

  alias A = Int64

  getter n : Int64
  getter st : LST(X,A)
  delegate "[]=", to: st

  def initialize(@n)
    @st = LST.new(
      values: Array.new(n) { X.new(0_i64) },
      fxx: ->(x : X, y : X) { x + y },
      fxa: ->(x : X, a : A) { x * a },
      faa: ->(a : A, b : A) { b }
    )
  end

  def [](r)
    st[r].sum
  end
end

alias RURS = RangeUpdateRangeSum

class Problem
  getter n : Int64
  getter a : Array(Int64)
  getter cnt : Array(RURS)
  getter sum : RURS

  def initialize(@n, @a)
    @cnt = Array.new(11) do
      RURS.new(n)
    end
    @sum = RURS.new(n)

    a.each_with_index do |v, i|
      cnt[v][i] = 1_i64
      sum[i] = v
    end
  end

  def sort(lo, hi)
    l = lo
    11.times do |i|
      c = cnt[i][lo...hi]
      cnt[i][lo...hi] = 0_i64
      cnt[i][l...(l+c)] = 1_i64
      sum[l...(l+c)] = i
      l += c
    end
  end
end

n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

pr = Problem.new(n,a)
pp pr