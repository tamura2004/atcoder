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
        left.nil? ? val : (wk = left.upper(k)).nil? ? val : wk < val ? wk : val
      else
        right.nil? ? nil : right.upper(k)
      end
    end

    def lower(k)
      if val <= k
        right.nil? ? val : (wk = right.lower(k)).nil? ? val : wk < val ? val : wk
      else
        left.nil? ? nil : left.lower(k)
      end
    end
  end
end

l, q = gets.split.map(&:to_i)
tree = Treap.new
tree << 0
tree << l

q.times do
  c, x = gets.split.map(&:to_i)
  case c
  when 1
    tree << x
  when 2
    pp tree.upper(x) - tree.lower(x)
  end
end
