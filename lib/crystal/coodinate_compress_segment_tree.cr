# 座標圧縮付セグ木
#
# ```
# A = 100_000_000_i64
# B = 200_000_000_i64
# C = 300_000_000_i64
# D = 400_000_000_i64
# st = CoodinateCompressSegmentTree(Int64).new(4, [A,B,C,D])
# st.set(A, 1)
# st.set(B, 2)
# st.set(C, 4)
# st.set(D, 8)
# puts st.get(B, D) # => 6
# puts st.get(B, Int64::MAX) # => 14
# ```
class CoodinateCompressSegmentTree(T)
  getter n : Int32
  getter ref : Array(T)
  getter a : Array(T)

  def initialize(@n, src)
    @ref = src.sort.uniq
    @a = Array.new(n*2, T.zero)
  end

  def from(x : T) : Int32
    ref.bsearch_index do |i|
      x <= i
    end || n
  end

  def set(x : T, v : T)
    i = from(x) + n
    a[i] = v
    while i > 1
      i >>= 1
      a[i] = a[i << 1] + a[i << 1 | 1]
    end
  end

  def get(x : T, y : T)
    i = from(x) + n
    j = from(y) + n
    lo = hi = T.zero
    while i < j
      (lo = lo + a[i]; i += 1) if i & 1 == 1
      (j -= 1; hi = a[j] + hi) if j & 1 == 1
      i >>= 1; j >>= 1
    end
    lo + hi
  end
end

alias CCST = CoodinateCompressSegmentTree(Int64)
