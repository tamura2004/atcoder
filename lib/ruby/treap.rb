class Treap
  attr_accessor :root

  def initialize(root = nil)
    @root = root
  end

  def nil_tree?
    root.nil?
  end

  def merge(other)
    return self if other.nil_tree?
    @root = nil_tree? ? other.root : root.merge(other.root)
    self
  end

  def split(k)
    left = right = nil
    left, right = root.split(k) unless nil_tree?
    [left, right]
  end

  def insert(v, pri)
    left, right = split(v)
    node = Node.new(v, pri)
    @root = left.nil? ? node : left.merge(node)
    @root = root.merge(right)
    self
  end

  def <<(v)
    insert(v, rand(1000000))
  end

  def upper(k)
    root.upper(k)
  end

  def lower(k)
    root.lower(k)
  end

  class Node
    attr_accessor :left, :right, :val, :pri, :size

    def initialize(val, pri)
      @val = val
      @pri = pri
      @size = 1
      @left = nil
      @right = nil
    end

    def merge(other)
      return self if other.nil?

      if pri < other.pri
        other.left = other.left.nil? ? self : merge(other.left)
        other.update
      else
        @right = right.nil? ? other : right.merge(other)
        update
      end
    end

    def split(k)
      if val < k
        fst, snd = right.nil? ? [nil, nil] : right.split(k)
        @right = fst
        [update, snd]
      else
        fst, snd = left.nil? ? [nil, nil] : left.split(k)
        @left = snd
        [fst, update]
      end
    end

    def update
      @size = (left&.size || 0) + (right&.size || 0) + 1
      self
    end

    def upper(k)
      if k <= val
        left.nil? ? val : left.upper(k)
      else
        right.nil? ? nil : right.upper(k)
      end
    end

    def lower(k)
      if val <= k
        right.nil? ? val : right.lower(k)
      else
        left.nil? ? nil : left.lower(k)
      end
    end
  end
end
