# TreapによるOrderedSet
#
# ```
# ```
class Treap(T)
  class Node(T)
    class_getter r = Xorshift.new

    getter key : T
    getter pri : Int64
    getter size : Int32
    getter sum : T
    property left : self?
    property right : self?

    def initialize(@key)
      @pri = @@r.get
      @size = 1
      @sum = key
    end

    def includes?(k : T) : Bool?
      if key == k
        true
      elsif key < k
        right.try &.includes?(k)
      else
        left.try &.includes?(k)
      end
    end

    def split(k : T)
      if key < k
        fst, snd = right.try &.split(k) || nil_node_pair
        @right = fst
        {update, snd}
      else
        fst, snd = left.try &.split(k) || nil_node_pair
        @left = snd
        {fst, update}
      end
    end

    def split_at(i : Int)
      ord = left_size
      if ord < i
        fst, snd = right.try &.split_at(i - ord - 1) || nil_node_pair
        @right = fst
        {update, snd}
      else
        fst, snd = left.try &.split_at(i) || nil_node_pair
        @left = snd
        {fst, update}
      end
    end

    def insert(node : self) : self
      if pri < node.pri
        node.left, node.right = split(node.key)
        node.update
      elsif key < node.key
        @right = right.try &.insert(node) || node
        update
      else
        @left = left.try &.insert(node) || node
        update
      end
    end

    def merge(b : self?)
      return self if b.nil?

      if pri > b.pri
        @right = right.try &.merge(b) || b
        update
      else
        b.left = merge(b.left)
        b.update
      end
    end

    def delete(k : T)
      if key == k
        left.try &.merge(right) || right
      elsif key < k
        @right = right.try &.delete(k)
        update
      else
        @left = left.try &.delete(k)
        update
      end
    end

    def left_size
      left.try &.size || 0
    end

    def right_size
      right.try &.size || 0
    end

    def left_sum
      left.try &.sum || T.zero
    end

    def right_sum
      right.try &.sum || T.zero
    end

    def left_to_a
      left.try &.to_a || [] of T
    end

    def right_to_a
      right.try &.to_a || [] of T
    end

    def nil_node
      nil.as(self?)
    end

    def nil_node_pair
      {nil_node, nil_node}
    end

    def update
      @size = left_size + right_size + 1
      @sum = left_sum + right_sum + key
      self
    end

    def inspect
      "(#{left.inspect} #{key} #{right.inspect})".gsub(/nil/, "")
    end

    def to_a
      left_to_a + [key] + right_to_a
    end

    def each(&block : T -> Nil)
      left.try &.each(&block)
      block.call(key)
      right.try &.each(&block)
    end
  end

  getter root : Node(T)?

  def initialize
    @root = nil_node
  end

  def initialize(k : T)
    @root = Node(T).new(k)
  end

  def initialize(@root : Node(T)?)
  end

  def includes?(k : T)
    root.try &.includes?(k)
  end

  def split(k : T) : Tuple(self, self)
    fst, snd = root.try &.split(k) || nil_node_pair
    {self.class.new(fst), self.class.new(snd)}
  end

  def split_at(i : Int) : Tuple(self, self)
    fst, snd = root.try &.split_at(i) || nil_node_pair
    {self.class.new(fst), self.class.new(snd)}
  end

  def insert(k : T) : self
    node = Node(T).new(k)
    @root = root.try &.insert(node) || node
    self
  end

  def <<(k) : self
    insert(T.new(k))
  end

  def merge(b : self) : self
    @root = root.try &.merge(b.root) || b.root
    self
  end

  def +(b : self) : self
    merge(b)
  end

  def delete(k : T) : self
    @root = root.try &.delete(k)
    self
  end

  def size : T?
    @root.try &.size || 0
  end

  def sum : T
    @root.try &.sum || T.zero
  end

  def nil_node
    nil.as(Node(T)?)
  end

  def nil_node_pair
    {nil_node, nil_node}
  end

  def empty?
    root.nil?
  end

  def inspect
    @root.inspect
  end

  def to_s
    inspect
  end

  def to_a
    root.try &.to_a || [] of T
  end

  def each(&block : T -> Nil)
    root.try &.each(&block)
  end

  class Xorshift
    getter x : Int64

    def initialize
      @x = 88172645463325252_i64
    end

    def get
      @x = x ^ (x << 7)
      @x = x ^ (x >> 9)
    end
  end
end
