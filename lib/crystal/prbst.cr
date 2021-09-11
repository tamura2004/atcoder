class PRBST(T)
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
    node = root.try &.merge(other.root) || other.root
    PRBST(T).new(node)
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
    node = left.try &.merge(right) || right
    {PRBST(T).new(mid), PRBST(T).new(node)}
  end

  def [](r : Range(T, T))
    mid, other = split(r)
    mid
  end

  def insert(v : T)
    left, right = split(v)
    new_node = Node(T).new(v)
    left = left.try &.merge(new_node) || new_node
    RBST(T).new(left.merge(right))
  end

  # 非永続
  def <<(v : T)
    left, right = split(v)
    new_node = Node(T).new(v)
    left = left.try &.merge(new_node) || new_node
    @root = left.merge(right)
  end

  def delete(k : T)
    lo, other = split(k, eq = false)
    mid, hi = other.try &.split_at(1) || {nil, nil}
    node = lo.try &.merge(hi) || hi
    PRBST(T).new(node)
  end

  def upper(k, eq = true)
    root.try &.upper(k, eq)
  end

  def lower(k, eq = true)
    root.try &.lower(k, eq)
  end

  def min
    root.try &.min
  end

  def max
    root.try &.max
  end

  # 非永続
  def shift
    fst, snd = root.try &.split_at(1) || {nil, nil}
    @root = snd
    fst.try &.val
  end

  # 非永続
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
    property size : Int32
    property left : Node(T)?
    property right : Node(T)?

    def initialize(@val)
      @size = 1
      @left = nil
      @right = nil
    end

    def dup
      node = Node(T).new(val)
      node.size = size
      node.left = left
      node.right = right
      node
    end

    def update
      @size = (left.try &.size || 0) + (right.try &.size || 0) + 1
      self
    end

    def merge(other : self?)
      return self if other.nil?

      if rand(size + other.size) < size
        node = dup
        node.right = right.try &.merge(other) || other
        node.update
      else
        node = other.dup
        node.left = node.left.try { |node| merge(node) } || self
        node.update
      end
    end

    def split(k, eq = true)
      if val < k || (eq && k == val)
        fst, snd = right.try &.split(k, eq) || {nil, nil}
        node = dup
        node.right = fst
        {node.update, snd}
      else
        fst, snd = left.try &.split(k, eq) || {nil, nil}
        node = dup
        node.left = snd
        {fst, node.update}
      end
    end

    # k番目より前と、k番目以降で分割 [min, k) [k, max)
    def split_at(k)
      k += size if k < 0
      cnt = left.try &.size || 0
      if cnt >= k
        fst, snd = left.try &.split_at(k) || {nil, nil}
        node = dup
        node.left = snd
        {fst, node.update}
      else
        fst, snd = right.try &.split_at(k - cnt - 1) || {nil, nil}
        node = dup
        node.right = fst
        {node.update, snd}
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
