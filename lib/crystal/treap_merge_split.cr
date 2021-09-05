# 乱択平衡二分探索木（ジェネリクス版）
class Treap(T)
  getter root : Node(T)?

  def initialize(@root : Node(T)? = nil)
  end

  def nil_tree?
    root.nil?
  end

  def size
    (node = root) ? node.size : 0
  end

  def merge(other : self)
    return self if other.nil_tree?
    @root = (node = @root) ? node.merge(other.root) : other.root
    self
  end

  def split(k : T, eq = true)
    (node = root) ? node.split(k, eq) : { nil, nil }
  end

  def split(r : Range(T,T))
    lo = r.begin
    hi = r.end
    left, tail = split(lo, eq = false)
    mid, right = tail ? tail.split(hi) : { nil, nil }
    @root = left ? left.merge(right) : right
    { Treap(T).new(mid), self }
    # left, mid = split(lo, eq = )
  end

  def insert(v : T, pri : Int32)
    left, right = split(v)
    new_node = Node(T).new(v, pri)
    left = left ? left.merge(new_node) : new_node
    @root = left.merge(right)
    self
  end

  def <<(v : T)
    insert(v, rand(Int32::MAX))
  end

  def delete(k : T)
    left, other = split(k, eq = false)
    mid, right = other ? other.split(k) : { nil, nil }
    @root = left ? left.merge(right) : right
    self
  end

  def upper(k, eq = true)
    (node = root).nil? ? nil : node.upper(k, eq)
  end

  def lower(k, eq = true)
    (node = root).nil? ? nil : node.lower(k, eq)
  end

  def min
    (node = root) ? node.min : nil
  end

  def max
    (node = root) ? node.max : nil
  end

  def shift
    if node = root
      k, new_node = node.shift
      @root = new_node
      k
    else
      nil
    end
    # (node = root) ? (wk = node.shift) ? wk.val : nil : nil
  end

  def each(&block : T -> _)
    (node = root) && node.each(&block)
  end

  def to_a
    (node = root) ? node.to_a : [] of T
  end

  class Node(T)
    getter val : T
    getter pri : Int32
    getter size : Int32
    property left : Node(T)?
    property right : Node(T)?

    def initialize(@val, @pri)
      @size = 1
      @left = nil
      @right = nil
    end

    def update
      @size = (left.try(&.size) || 0) + (right.try(&.size) || 0) + 1
      self
    end

    def merge(other : self?)
      return self if other.nil?

      if pri < other.pri
        other.left = other.left ? merge(other.left) : self
        other.update
      else
        @right = (node = @right) ? node.merge(other) : other
        update
      end
    end

    def split(k, eq = true)
      if val < k || (eq && k == val)
        fst, snd = (node = right) ? node.split(k, eq) : { nil, nil }
        @right = fst
        { update, snd }
      else
        fst, snd = (node = left) ? node.split(k, eq) : { nil, nil }
        @left = snd
        { fst, update }
      end
    end

    def upper(k, eq = true)
      if k < val || (eq && k == val)
        (node = left) ? (wk = node.upper(k, eq)) ? Math.min(val, wk) : val : val
      else
        (node = right) ? node.upper(k, eq) : nil
      end
    end

    def lower(k, eq = true)
      if val < k || (eq && k == val)
        (node = right) ? (wk = node.lower(k, eq)) ? Math.max(val, wk) : val : val
      else
        (node = left) ? node.lower(k, eq) : nil
      end
    end

    def min
      (node = left) ? node.min : val
    end

    def max
      (node = right) ? node.max : val
    end

    def shift : Tuple(T?, Node(T)?)
      # (node = left) ? node.left ? node.shift : (@left = nil; node) : nil
      if node = left
        k, new_node = node.shift
        @left = new_node
        { k, self }
      else
        { val, nil }
      end
    end

    def each(&block : T -> _)
      (node = left) && node.each(&block)
      block.call(val)
      (node = right) && node.each(&block)
    end

    def to_a
      l = (node = left) ? node.to_a : [] of T
      r = (node = right) ? node.to_a : [] of T
      l + [val] + r
    end
  end
end
