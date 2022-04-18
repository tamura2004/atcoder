class SuccinctIndexableDictionary
  getter length : UInt32
  getter blocks : UInt32
  getter bit : Array(UInt32)
  getter sum : Array(UInt32)

  def initialize(@length : UInt32)
    @blocks = (length + 31) >> 5
    @bit = Array.new(blocks, 0u32)
    @sum = Array.new(blocks, 0u32)
  end

  def set(k : Int32)
    bit[k >> 5] |= 1u32 << (k & 31)
  end

  def build
    sum[0] = 0u32
    (1...blocks).each do |i|
      sum[i] = sum[i - 1] + bit[i - 1].popcount
    end
  end

  def [](k : Int) : Bool
    !((bit[k >> 5] >> (k & 31)) & 1).zero?
  end

  def rank(k : Int) : Int
    x = bit[k >> 5] & ((1u32 << (k & 31)) - 1)
    (sum[k >> 5] + x.popcount).to_i32
  end

  def rank(val : Bool, k : Int) : Int
    val ? rank(k) : k - rank(k)
  end
end

class OriginalWaveletMatrix(T)
  getter maxlog : Int32
  getter matrix : Array(SuccinctIndexableDictionary)
  getter mid : Array(Int32)
  getter length : Int32

  def initialize(v : Array(Int))
    max_value = v.max
    x = max_value < 0 ? ~max_value : max_value
    @maxlog = sizeof(typeof(max_value)) * 8 - x.leading_zeros_count
    @mid = Array.new(maxlog, 0)
    @length = v.size
    l = Array(Int32).new(length, 0)
    r = Array(Int32).new(length, 0)

    @matrix = Array(SuccinctIndexableDictionary).new(maxlog) do |i|
      SuccinctIndexableDictionary.new(length.succ.to_u32)
    end

    (0...maxlog).reverse_each do |level|
      left, right = 0, 0
      length.times do |i|
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

  def rank(x : T, r : Int) : Int
    l = 0
    (0...maxlog).reverse_each do |level|
      l, r = succ(!((x >> level) & 1).zero?, l, r, level)
    end
    r - l
  end

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

  def kth_largest(l : Int, r : Int, k : Int) : T
    kth_smallest(l, r, r - l - k - 1)
  end

  def range_freq(l : Int, r : Int, lower : T, upper : T) : Int
    range_freq(l, r, upper) - range_freq(l, r, lower)
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
end

class WaveletMatrix(T)
  getter size : Int32
  getter ys : Array(T)
  getter max_value : T
  getter mat : OriginalWaveletMatrix(Int32)
  getter h : Hash(T, Int32)

  def initialize(v : Array(T))
    @size = v.size
    @ys = v.sort.uniq
    @max_value = v.max
    @h = {} of T => Int32
    ys.each_with_index { |e, i| h[e] = i }
    @mat = OriginalWaveletMatrix(Int32).new(v.map { |vi| index(vi) })
  end

  def [](k : Int) : T
    ys[mat[k]]
  end

  def count(range : Range, x : Int) : Int
    return 0 unless h.has_key?(x)
    l, r = both_ends(range)
    c2 = rank(x, r.succ)
    c1 = l != 0 ? rank(x, l) : 0
    c2 - c1
  end

  def count(range : Range, x : Range) : Int
    l, r = both_ends(range)
    min, max = x.begin, x.end
    max -= 1 if max && x.excludes_end?
    max = kth_largest(range, 0) unless max
    max = max_value if max > max_value
    if min
      return 0 if min > @max_value
      max < max_value ? range_freq(l, r.succ, min, max.succ) : (range_freq(l, r.succ, min, @max_value) + self.count(range, @max_value))
    else
      max < max_value ? range_freq(l, r.succ, max.succ) : (range_freq(l, r.succ, @max_value) + self.count(range, @max_value))
    end
  end

  def kth_smallest(range : Range, k : Int) : T
    l, r = both_ends(range)
    _kth_smallest(l, r.succ, k)
  end

  def kth_largest(range : Range, k : Int) : T
    l, r = both_ends(range)
    _kth_largest(l, r.succ, k)
  end

  def less_than(range : Range, x : T) : T?
    l, r = both_ends(range)
    if x > max_value
      return max_value if count(range, max_value) == 1
      x = max_value
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
    b += size if b < 0
    e += size if e < 0
    return b, e
  end

  def rank(x : T, r : Int) : Int
    pos = index(x)
    return 0 if pos == ys.size || ys[pos] != x
    return mat.rank(pos, r)
  end

  private def _kth_smallest(l : Int, r : Int, k : Int) : T
    ys[mat.kth_smallest(l, r, k)]
  end

  private def _kth_largest(l : Int, r : Int, k : Int) : T
    ys[mat.kth_largest(l, r, k)]
  end

  private def range_freq(l : Int, r : Int, lower : T, upper : T) : Int
    return 0 if lower > max_value
    mat.range_freq(l, r, index(lower), index(upper))
  end

  private def range_freq(l : Int, r : Int, upper : T) : Int
    mat.range_freq(l, r, index(upper))
  end

  private def prev_value(l : Int, r : Int, upper : T) : T?
    ret = mat.prev_value(l, r, index(upper))
    ret == -1 ? nil : ys[ret]
  end

  private def next_value(l : Int, r : Int, lower : T) : T?
    idx = index(lower)
    return nil unless idx
    ret = mat.next_value(l, r, idx)
    ret == -1 ? nil : ys[ret]
  end

  private def index?(x : T)
    h.has_key?(x) ? h[x] : ys.bsearch_index { |val| val >= x }
  end

  private def index(x : T) : Int
    h.has_key?(x) ? h[x] : ys.bsearch_index { |val| val >= x }.not_nil!
  end
end

alias WM = WaveletMatrix

# n = gets.to_s.to_i
# a = gets.to_s.split.map(&.to_i64)
# wm = WM.new(a)
# read_line.to_i.times do
#   l, r, x = read_line.split.map(&.to_i64)
#   puts wm.count(l.pred..r.pred, x)
# end

a = [1, 1, 2, 2, 3, 3, 4, 5]
wm = WM.new(a)
pp wm.count(0..3, 2)
