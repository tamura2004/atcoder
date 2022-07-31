require "crystal/original_wavelet_matrix"

class CompressedWaveletMatrix(T)
  getter :size
  @size : Int32
  @ys : Array(T)
  @max_value : T
  @mat : OriginalWaveletMatrix(Int32)

  def initialize(v : Array(T))
    @size = v.size
    @ys = v.sort.uniq
    @max_value = v.max
    @h = {} of T => Int32
    @ys.each_with_index { |e, i| @h[e] = i }
    @mat = OriginalWaveletMatrix(Int32).new(v.map { |vi| index(vi) })
  end

  # k番目の値
  def [](k : Int) : T
    @ys[@mat[k]]
  end

  # 範囲内でのxの出現回数
  def count(range : Range, x) : Int32
    x = T.new(x)
    l, r = both_ends(range)
    c2 = rank(x, r.succ)
    c1 = l != 0 ? rank(x, l.pred) : 0
    c2 - c1
  end

  def count(range : Range, x : Range) : Int32
    l, r = both_ends(range)
    min, max = x.begin, x.end
    max -= 1 if max && x.excludes_end?
    max = kth_largest(range, 0) unless max
    max = @max_value if max > @max_value
    if min
      max < @max_value ? range_freq(l, r.succ, min, max.succ) : (range_freq(l, r.succ, min, @max_value) + self.count(range, @max_value))
    else
      max < @max_value ? range_freq(l, r.succ, max.succ) : (range_freq(l, r.succ, @max_value) + self.count(range, @max_value))
    end
  end

  def kth_smallest(range : Range, k : Int32) : T
    l, r = both_ends(range)
    _kth_smallest(l, r.succ, k)
  end

  def kth_largest(range : Range, k : Int32) : T
    l, r = both_ends(range)
    _kth_largest(l, r.succ, k)
  end

  def less_than(range : Range, x) : T?
    x = T.new(x)
    l, r = both_ends(range)
    if x > @max_value
      return @max_value if count(range, @max_value) == 1
      x = @max_value
    end
    prev_value(l, r.succ, x)
  end

  def larger_than(range : Range, x) : T?
    x = T.new(x)
    ceil(range, x.succ)
  end

  def ceil(range : Range, x) : T?
    x = T.new(x)
    l, r = both_ends(range)
    next_value(l, r.succ, x)
  end

  def floor(range : Range, x) : T?
    x = T.new(x)
    less_than(range, x.succ)
  end

  private def both_ends(range : Range)
    b, e = range.begin, range.end - (range.excludes_end? ? 1 : 0)
    b += @size if b < 0
    e += @size if e < 0
    return b, e
  end

  private def rank(x : T, r : Int32) : Int32
    pos = index(x)
    return 0 if pos == @ys.size || @ys[pos] != x
    return @mat.rank(pos, r)
  end

  private def _kth_smallest(l : Int32, r : Int32, k : Int32) : T
    @ys[@mat.kth_smallest(l, r, k)]
  end

  private def _kth_largest(l : Int32, r : Int32, k : Int32) : T
    @ys[@mat.kth_largest(l, r, k)]
  end

  private def range_freq(l : Int32, r : Int32, lower : T, upper : T) : Int32
    @mat.range_freq(l, r, index(lower), index(upper))
  end

  private def range_freq(l : Int32, r : Int32, upper : T) : Int32
    @mat.range_freq(l, r, index(upper))
  end

  private def prev_value(l : Int32, r : Int32, upper : T) : T?
    ret = @mat.prev_value(l, r, index(upper))
    ret == -1 ? nil : @ys[ret]
  end

  private def next_value(l : Int32, r : Int32, lower : T) : T?
    idx = index(lower)
    return nil unless idx
    ret = @mat.next_value(l, r, idx)
    ret == -1 ? nil : @ys[ret]
  end

  private def index(x : T) : Int32
    @h.has_key?(x) ? @h[x] : @ys.bsearch_index { |val| val >= x }.not_nil!
  end
end