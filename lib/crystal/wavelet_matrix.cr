require "crystal/succinct_indexable_dictionary"

# ウェーブレット行列
class WaveletMatrix(T)
  alias Rng = Range(Int::Primitive?, Int::Primitive?)

  getter maxlog : Int32
  getter matrix : Array(SID)
  getter mid : Array(Int32)
  getter size : Int32

  def initialize(v : Array(Int))
    v = v.dup
    # max_value = v.max
    # x = max_value < 0 ? ~max_value : max_value
    @maxlog = sizeof(T) * 8 #sizeof(typeof(max_value)) * 8 - x.leading_zeros_count
    @mid = Array.new(maxlog, 0)
    @size = v.size
    @matrix = Array.new(maxlog) { SID.new(size + 1) }

    l = Array(T).new(size, 0)
    r = Array(T).new(size, 0)

    (0...maxlog).reverse_each do |level|
      left, right = 0, 0
      size.times do |i|
        if !((v[i] >> level) & 1).zero?
          matrix[level].set(i)
          r[right] = v[i]
          right += 1
        else
          l[left] = v[i]
          left += 1
        end
      end
      mid[level] = left
      matrix[level].build
      v, l = l, v
      right.times do |i|
        v[left + i] = r[i]
      end
    end
  end

  # k番目の値
  def [](k : Int) : T
    ret = 0
    (0...maxlog).reverse_each do |level|
      f = matrix[level][k]
      ret |= 1 << level if f
      k = matrix[level].rank(f, k) + mid[level] * (f ? 1 : 0)
    end
    ret
  end

  private def succ(f : Bool, l : Int, r : Int, level : Int)
    return matrix[level].rank(f, l) + mid[level] * (f ? 1 : 0), matrix[level].rank(f, r) + mid[level] * (f ? 1 : 0)
  end

  # [0, r)でのxの出現回数
  def rank(x : T, r : Int) : Int
    l = 0
    (0...maxlog).reverse_each do |level|
      l, r = succ(!((x >> level) & 1).zero?, l, r, level)
    end
    r - l
  end

  # [lo,hi)でのxの出現回数
  def rank(x : T, r : Range(Int::Primitive?, Int::Primitive?))
    lo = r.begin || 0
    hi = (r.end || size - 1) + (r.excludes_end? ? 0 : 1)
    rank(x, hi) - rank(x, lo)
  end

  # [l,r)でk番目に小さい数
  def kth_smallest(l : Int, r : Int, k : Int) : T
    raise IndexError.new unless 0 <= k && k < r - l
    ret = 0
    (0...maxlog).reverse_each do |level|
      cnt = matrix[level].rank(false, r) - matrix[level].rank(false, l)
      f = cnt <= k
      if f
        ret |= 1 << level
        k -= cnt
      end
      l, r = succ(f, l, r, level)
    end
    ret
  end

  # 範囲内でk番目に小さい
  def kth_smallest(r : Rng, k : Int)
    lo, hi = range_to_tuple(r)
    kth_smallest(lo, hi, k)
  end

  # 範囲内でk番目に多きい
  def kth_largest(l : Int, r : Int, k : Int) : T
    kth_smallest(l, r, r - l - k - 1)
  end

  # 範囲内でk番目に多きい
  def kth_largest(r : Rng, k : Int) : T
    lo, hi = range_to_tuple(r)
    kth_largest(lo, hi, k)
  end

  # インデックス範囲、値の範囲での出現回数
  def range_freq(l : Int, r : Int, lower : T, upper : T) : Int
    range_freq(l, r, upper) - range_freq(l, r, lower)
  end

  # インデックス範囲、値の範囲での出現回数
  def range_freq(r : Rng, value_range : Range(T?,T?))
    lo, hi = range_to_tuple(r)
    lower = value_range.begin || T::MIN
    upper = (value_range.end || T::MAX - 1) + (value_range.excludes_end? ? 0 : 1)
    range_freq(lo, hi, lower, upper)
  end

  def range_freq(l : Int, r : Int, upper : T) : Int
    ret = 0
    (0...maxlog).reverse_each do |level|
      f = !((upper >> level) & 1).zero?
      ret += matrix[level].rank(false, r) - matrix[level].rank(false, l) if f
      l, r = succ(f, l, r, level)
    end
    ret
  end

  def prev_value(l : Int, r : Int, upper : T) : Int
    cnt = range_freq(l, r, upper)
    cnt == 0 ? -1 : kth_smallest(l, r, cnt - 1)
  end

  def next_value(l : Int, r : Int, lower : T) : Int
    cnt = range_freq(l, r, lower)
    cnt == r - l ? -1 : kth_smallest(l, r, cnt)
  end

  def range_to_tuple(r : Rng)
    lo = r.begin || 0
    hi = (r.end || size - 1) + (r.excludes_end? ? 0 : 1)
    {lo, hi}
  end
end

module Indexable(T)
  def to_wm
    WaveletMatrix(T).new(self)
  end
end
