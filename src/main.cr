# 座標圧縮付セグ木
#
# ```
# A = 100_000_000_i64
# B = 200_000_000_i64
# C = 300_000_000_i64
# D = 400_000_000_i64
# st = CoodinateCompressSegmentTree(Int64).new(4, [A, B, C, D])
# st.set(A, 1)
# st.set(B, 2)
# st.set(C, 4)
# st.set(D, 8)
# puts st.get(B, D)          # => 6
# puts st.get(B, Int64::MAX) # => 14
# ```
class CoodinateCompressSegmentTree(T)
  getter n : Int32
  getter ref : Array(T)
  getter a : Array(T)

  def initialize(src)
    src << T::MIN
    src << T::MAX
    @ref = src.sort.uniq
    @n = ref.size
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

  def add(x : T, v : T)
    i = from(x) + n
    a[i] += v
    while i > 1
      i >>= 1
      a[i] = a[i << 1] + a[i << 1 | 1]
    end
  end

  def get(x : T)
    i = n
    j = from(x+1) + n
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

n, m = gets.to_s.split.map { |v| v.to_i64 }
q = [] of Tuple(Int64, Int32, Int64, Int64)
src = [] of Int64

lnds = Array.new(n) do
  x, y, d, c = gets.to_s.split.map { |v| v.to_i64 }
  q << {x, 1, y, c}
  q << {x, 1, y + d + 1, -c}
  q << {x + d + 1, 1, y, -c}
  q << {x + d + 1, 1, y + d + 1, c}
  src << y
  src << y + d + 1
end

blds = Array.new(m) do |i|
  x, y = gets.to_s.split.map { |v| v.to_i64 }
  q << {x, 2, y, i.to_i64}
  src << y
end

q.sort!
st = CCST.new(src)

ans = Array.new(m, 0_i64)

q.each do |x, cmd, y, c|
  case cmd
  when 1
    st.add(y, c)
  when 2
    ans[c.to_i] = st.get(y)
  end
end

puts ans.join("\n")
