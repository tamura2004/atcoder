class PersistentArray
  class Node
    property left : Node?
    property right : Node?
    property val : Int64

    def initialize(@val = 0_i64, @left = nil, @right = nil)
    end
  end

  getter root : Node?
  getter h : Int32

  def initialize(
    @h = 32,
    @root = nil.as(Node?)
  )
  end

  # 参照
  def [](i)
    get(root, i, h)
  end

  def get(node : Node?, i, d)
    return 0_i64 if node.nil?
    return node.val if d.zero?

    if i.bit(d - 1).zero?
      get(node.left, i, d - 1)
    else
      get(node.right, i, d - 1)
    end
  end

  # 非破壊更新
  def update(i, v)
    nex_root = update(root.try(&.dup) || Node.new, root, i, v, h)
    PersistentArray.new(h, nex_root)
  end

  def update(node, old_node, i, v, d)
    if d.zero?
      node.val = v
    elsif i.bit(d - 1).zero?
      old_node_left = old_node.try(&.left)
      new_node_left = old_node_left.try(&.dup) || Node.new
      node.left = update(new_node_left, old_node_left, i, v, d - 1)
    else
      old_node_right = old_node.try(&.right)
      new_node_right = old_node_right.try(&.dup) || Node.new
      node.right = update(new_node_right, old_node_right, i, v, d - 1)
    end
    node
  end

  # 破壊的代入
  def []=(i, v)
    set(i, v)
  end
  
  def set(i, v)
    set(@root = root || Node.new, i, v, h)
  end

  # 破壊的代入
  def set(node, i, v, d)
    if d.zero?
      node.val = v
    elsif i.bit(d - 1).zero?
      set(node.left = node.try(&.left) || Node.new, i, v, d - 1)
    else
      set(node.right = node.try(&.right) || Node.new, i, v, d - 1)
    end
    v
  end
end

alias T = Int64
# セグメント木
class ST
  getter n : Int32
  getter a : PersistentArray
  getter fxx : Proc(T, T, T)

  def initialize(values : Array(T), &fxx : (T, T) -> T)
    @fxx = fxx
    @n = Math.pw2ceil(values.size)
    @a = PersistentArray.new
    values.each_with_index do |v, i|
      a[i + n] = v
    end
    (1...n).reverse_each do |i|
      a[i] = @fxx.call(a[i*2], a[i*2 + 1])
    end
  end

  def initialize(@n, @a, @fxx)
    (1...n).reverse_each do |i|
      a[i] = @fxx.call(a[i*2], a[i*2 + 1])
    end
  end

  def put(i, v)
    i += n
    a[i] = v
    while i > 1
      i >>= 1
      a[i] = fxx.call(a[i*2], a[i*2 + 1])
    end
  end

  def []=(i, v)
    put(i, v)
  end

  def get(i)
    a[i + n]
  end

  def [](i : Int)
    get(i)
  end

  def []?(i : Int)
    get(i)
  end

  def query(lo, hi)
    lo += n
    hi += n

    left = right = 0_i64

    while lo < hi
      if lo.odd?
        left = fxx.call left, a[lo]
        lo += 1
      end

      if hi.odd?
        hi -= 1
        right = fxx.call a[hi], right
      end

      lo >>= 1
      hi >>= 1
    end

    fxx.call left, right
  end

  def [](lo, hi)
    query(lo, hi).not_nil!
  end

  def []?(lo, hi)
    query(lo, hi)
  end

  def [](r : Range(Int::Primitive?, Int::Primitive?))
    lo = (r.begin || 0).clamp(0..n-1)
    hi = (r.end.try(&.+(1).-(r.excludes_end?.to_unsafe)) || n).clamp(0..n)
    self[lo, hi]
  end

  def []?(r : Range(Int::Primitive?, Int::Primitive?))
    lo = (r.begin || 0).clamp(0..n-1)
    hi = (r.end.try(&.+(1).-(r.excludes_end?.to_unsafe)) || n).clamp(0..n)
    self[lo, hi]?
  end

  def sum
    self[0..]
  end

  def bsearch(lo)
    (lo...n - 1).bsearch do |i|
      yield self[lo..i]
    end
  end

  def to_s(io)
    (0..Math.ilogb(n)).each do |h|
      io << a[(1 << h)...(1 << (h + 1))].join(" ")
      io << "\n"
    end
  end
end

struct Int
  def to_st_sum
    values = Array.new(self, 0_i64)
    ST.new(values) do |x, y|
      x + y
    end
  end

  def to_st_min
    values = Array.new(self, Int64::MAX)
    ST.new(values) do |x, y|
      x < y ? x : y
    end
  end

  def to_st_max
    values = Array.new(self, Int64::MIN)
    ST.new(values) do |x, y|
      x > y ? x : y
    end
  end
end

module Indexable(T)
  def to_st_sum
    ST.new(self) do |x, y|
      x + y
    end
  end

  def to_st_min
    ST.new(self) do |x, y|
      x < y ? x : y
    end
  end

  def to_st_max
    ST.new(self) do |x, y|
      x > y ? x : y
    end
  end
end

alias SegmentTree = ST

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

st = [n.to_st_sum]
idx = a.zip(0..).sort
idx.each do |v, i|
  st << ST.new(
    st[-1].n,
    st[-1].a.update(i + n, st[-1].a[i + n] + v),
    st[-1].fxx,
  )
end

q = gets.to_s.to_i64
b = 0_i64
q.times do
  p1, p2, p3 = gets.to_s.split.map(&.to_i64)
  left = p1 ^ b
  right = p2 ^ b
  x = p3 ^ b

  j = (idx.bsearch_index do |(v, i)|
    x < v
  end) || n

  b = st[j][left-1..right-1]
  pp b
end

