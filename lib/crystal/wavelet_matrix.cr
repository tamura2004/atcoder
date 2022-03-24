class SuccinctIndexableDictionary
  @length : UInt32
  @blocks : UInt32
  @bit : Array(UInt32)
  @sum : Array(UInt32)

  def initialize(length : UInt32)
    @length = length
    @blocks = (@length + 31) >> 5
    @bit = Array.new(@blocks, 0u32)
    @sum = Array.new(@blocks, 0u32)
  end

  def set(k : Int32)
    @bit[k >> 5] |= 1u32 << (k & 31)
  end

  def build
    @sum[0] = 0u32
    (1...@blocks).each do |i|
      @sum[i] = @sum[i - 1] + @bit[i - 1].popcount
    end
  end

  def [](k : Int32) : Bool
    !((@bit[k >> 5] >> (k & 31)) & 1).zero?
  end

  def rank(k : Int32) : Int32
    x = @bit[k >> 5] & ((1u32 << (k & 31)) - 1)
    (@sum[k >> 5] + x.popcount).to_i32
  end

  def rank(val : Bool, k : Int32) : Int32
    val ? rank(k) : k - rank(k)
  end
end

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

  def [](k : Int) : T
    @ys[@mat[k]]
  end

  def count(range : Range, x : Int) : Int32
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

  def less_than(range : Range, x : T) : T?
    l, r = both_ends(range)
    if x > @max_value
      return @max_value if count(range, @max_value) == 1
      x = @max_value
    end
    prev_value(l, r.succ, x)
  end

  def larger_than(range : Range, x : T) : T?
    ceil(range, x.succ)
  end

  def ceil(range : Range, x : T) : T?
    l, r = both_ends(range)
    next_value(l, r.succ, x)
  end

  def floor(range : Range, x : T) : T?
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

class OriginalWaveletMatrix(T)
  @maxlog : Int32
  @matrix : Array(SuccinctIndexableDictionary)
  @mid : Array(Int32)
  @length : Int32

  def initialize(v : Array(Int))
    max_value = v.max
    x = max_value < 0 ? ~max_value : max_value
    @maxlog = sizeof(typeof(max_value)) * 8 - x.leading_zeros_count
    @mid = Array.new(@maxlog, 0)
    @length = v.size
    l = Array(Int32).new(@length, 0)
    r = Array(Int32).new(@length, 0)
    @matrix = Array(SuccinctIndexableDictionary).new(@maxlog) { |i|
      SuccinctIndexableDictionary.new(@length.succ.to_u32)
    }
    @maxlog.pred.downto(0) do |level|
      left, right = 0, 0
      @length.times do |i|
        if !((v[i] >> level) & 1).zero?
          @matrix[level].set(i)
          r[right] = v[i]
          right += 1
        else
          l[left] = v[i]
          left += 1
        end
      end
      @mid[level] = left
      @matrix[level].build
      v, l = l, v
      right.times do |i|
        v[left + i] = r[i]
      end
    end
  end

  def [](k : Int32) : T
    ret = 0
    @maxlog.pred.downto(0) do |level|
      f = @matrix[level][k]
      ret |= 1 << level if f
      k = @matrix[level].rank(f, k) + @mid[level] * (f ? 1 : 0)
    end
    ret
  end

  private def succ(f : Bool, l : Int32, r : Int32, level : Int32)
    return @matrix[level].rank(f, l) + @mid[level] * (f ? 1 : 0), @matrix[level].rank(f, r) + @mid[level] * (f ? 1 : 0)
  end

  def rank(x : T, r : Int32) : Int32
    l = 0
    @maxlog.pred.downto(0) do |level|
      l, r = succ(!((x >> level) & 1).zero?, l, r, level)
    end
    r - l
  end

  def kth_smallest(l : Int32, r : Int32, k : Int32) : T
    raise IndexError.new unless 0 <= k && k < r - l
    ret = 0
    @maxlog.pred.downto(0) do |level|
      cnt = @matrix[level].rank(false, r) - @matrix[level].rank(false, l)
      f = cnt <= k
      if f
        ret |= 1 << level
        k -= cnt
      end
      l, r = succ(f, l, r, level)
    end
    ret
  end

  def kth_largest(l : Int32, r : Int32, k : Int32) : T
    kth_smallest(l, r, r - l - k - 1)
  end

  def range_freq(l : Int32, r : Int32, lower : T, upper : T) : Int32
    range_freq(l, r, upper) - range_freq(l, r, lower)
  end

  def range_freq(l : Int32, r : Int32, upper : T) : Int32
    ret = 0
    @maxlog.pred.downto(0) do |level|
      f = !((upper >> level) & 1).zero?
      ret += @matrix[level].rank(false, r) - @matrix[level].rank(false, l) if f
      l, r = succ(f, l, r, level)
    end
    ret
  end

  def prev_value(l : Int32, r : Int32, upper : T) : Int32
    cnt = range_freq(l, r, upper)
    cnt == 0 ? -1 : kth_smallest(l, r, cnt - 1)
  end

  def next_value(l : Int32, r : Int32, lower : T) : Int32
    cnt = range_freq(l, r, lower)
    cnt == r - l ? -1 : kth_smallest(l, r, cnt)
  end
end

tr = OriginalWaveletMatrix(Int32).new([1,9,2,3,6,4,3,2])
pp tr.kth_smallest(1,4,0)
pp tr.kth_smallest(1,4,1)
pp tr.kth_smallest(1,4,2)
