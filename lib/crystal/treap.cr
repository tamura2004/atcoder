class Treap(T)
  class Node(T)
    class_getter r = Xorshift.new

    getter key : T
    getter pri : Int64
    getter size : Int32
    property left : self?
    property right : self?

    def initialize(@key)
      @pri = @@r.get
      @size = 1
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

    {% for dir in %w(left right) %}
      {% for op in %w(size) %}
        @[AlwaysInline]
        private def {{dir.id}}_{{op.id}}
          {{dir.id}}.try &.{{op.id}} || 0
        end
      {% end %}
    {% end %}

    def nil_node
      nil.as(self?)
    end

    def nil_node_pair
      {nil_node, nil_node}
    end

    def update
      @size = left_size + right_size + 1
      self
    end

    def inspect
      "(#{left.inspect} #{key} #{right.inspect})".gsub(/nil/, "")
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

  def split(k : T)
    fst, snd = root.try &.split(k) || nil_node_pair
    {self.class.new(fst), self.class.new(snd)}
  end

  def insert(k : T)
    node = Node(T).new(k)
    @root = root.try &.insert(node) || node
  end

  def <<(k)
    insert(T.new(k))
  end

  def merge(b : self)
    return self if b.root.nil?
    @root = root.try &.merge(b.root) || b.root
  end

  def delete(k : T)
    @root = root.try &.delete(k)
  end

  def size
    @root.try &.size || 0
  end

  def nil_node
    nil.as(Node(T)?)
  end

  def nil_node_pair
    {nil_node, nil_node}
  end

  def inspect
    @root.inspect
  end

  def to_s
    inspect
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
