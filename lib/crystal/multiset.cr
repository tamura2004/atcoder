# 順序付き多重集合
#
# ```
# ms = Multiset(Int32).new
# ms << 100
# ms << 1
# ms << 50
# ms.min # => 1
# ms.max # => 100
# ```
class Multiset(T)
  getter root : Node(T)?

  def initialize(@root : Node(T)? = nil)
  end

  def nil_tree?
    root.nil?
  end

  def size
    root.try &.size || 0
  end

  def merge(other : self)
    return self if other.nil_tree?
    @root = root.try &.merge(other.root) || other.root
    self
  end

  def split(k : T, eq = true)
    root.try &.split(k, eq) || {nil, nil}
  end

  def split_at(k)
    k += size if k < 0
    root.try &.split_at(k) || {nil, nil}
  end

  def split(r : Range(T, T))
    lo = r.begin
    hi = r.end
    left, tail = split(lo, eq = false)
    mid, right = tail.try &.split(hi) || {nil, nil}
    @root = left.try &.merge(right) || right
    # {Treap(T).new(mid), self}
    {mid, self}
  end

  def insert(v : T)
    left, right = split(v)
    new_node = Node(T).new(v)
    left = left.try &.merge(new_node) || new_node
    @root = left.merge(right)
    self
  end

  def <<(v : T)
    insert(v)
  end

  def delete(k : T)
    left, other = split(k, eq = false)
    mid, right = other.try &.split_at(1) || {nil, nil}
    @root = left.try &.merge(right) || right
    self
  end

  def upper(k, eq = true)
    root.try &.upper(k, eq)
  end

  def lower(k, eq = true)
    root.try &.lower(k, eq)
  end

  def includes?(v)
    root.try &.includes?(v)
  end

  # 先頭からk番目の要素
  def at(k)
    root.try &.at(k)
  end

  def [](k)
    at(k)
  end

  # 中央値
  def median
    root.try(&.size).try do |s|
      if s.odd?
        at(s // 2)
      else
        at(s // 2).try do |left|
          left
          at((s - 1) // 2).try do |right|
            (left + right) / 2
          end
        end
      end
    end
  end

  def min
    root.try &.min
  end

  def max
    root.try &.max
  end

  def shift
    fst, snd = root.try &.split_at(1) || {nil, nil}
    @root = snd
    fst.try &.val
  end

  def pop
    fst, snd = root.try &.split_at(-1) || {nil, nil}
    @root = fst
    snd.try &.val
  end

  def each(&block : T -> _)
    root.try &.each(&block)
  end

  def to_a
    root.try &.to_a || [] of T
  end

  class Node(T)
    getter val : T
    getter size : Int32
    property left : Node(T)?
    property right : Node(T)?

    def initialize(@val)
      @size = 1
      @left = nil
      @right = nil
    end

    def update
      @size = (left.try &.size || 0) + (right.try &.size || 0) + 1
      self
    end

    def merge(other : self?)
      return self if other.nil?

      if rand(size + other.size) < size
        @right = right.try &.merge(other) || other
        update
      else
        other.left = other.left.try { |node| merge(node) } || self
        other.update
      end
    end

    def split(k, eq = true)
      if val < k || (eq && k == val)
        fst, snd = right.try &.split(k, eq) || {nil, nil}
        @right = fst
        {update, snd}
      else
        fst, snd = left.try &.split(k, eq) || {nil, nil}
        @left = snd
        {fst, update}
      end
    end

    # k番目より前と、k番目以降で分割 [min, k) [k, max)
    def split_at(k)
      k += size if k < 0
      cnt = left.try &.size || 0
      if cnt >= k
        fst, snd = left.try &.split_at(k) || {nil, nil}
        @left = snd
        {fst, update}
      else
        fst, snd = right.try &.split_at(k - cnt - 1) || {nil, nil}
        @right = fst
        {update, snd}
      end
    end

    def upper(k, eq = true)
      if k < val || (eq && k == val)
        left.try(&.upper(k, eq)).try { |v| Math.min(v, val) } || val
      else
        right.try &.upper(k, eq)
      end
    end

    def lower(k, eq = true)
      if val < k || (eq && k == val)
        right.try(&.lower(k, eq)).try { |v| Math.max(v, val) } || val
      else
        left.try &.lower(k, eq)
      end
    end

    def includes?(v)
      return true if v == val
      if v < val
        left.try &.includes?(v)
      else
        right.try &.includes?(v)
      end
    end

    def at(k)
      ord = left.try &.size || 0

      if k == ord
        val
      elsif k < ord
        left.try &.at(k)
      else
        right.try &.at(k - ord - 1)
      end
    end

    def min
      left.try &.min || val
    end

    def max
      right.try &.max || val
    end

    def each(&block : T -> _)
      left.try &.each(&block)
      block.call(val)
      right.try &.each(&block)
    end

    def to_a
      l = left.try &.to_a || [] of T
      r = right.try &.to_a || [] of T
      l + [val] + r
    end
  end
end

module Indexable(T)
  def to_multiset
    Multiset(T).new.tap do |ms|
      each do |v|
        ms << v
      end
    end
  end
end
