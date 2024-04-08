# 乱択を利用した平衡二分探索木
#
# 遅延評価
# 区間更新、区間最小
# 区間反転、区間ローテート
class ImplicitTreap(T)
  alias Rng = Range(Int::Primitive?, Int::Primitive?)

  class Node(T)
    class_getter r = Xorshift.new

    property val : T
    getter min : T
    getter lazy : T
    getter pri : Int64
    getter size : Int32
    getter rev : Bool
    property left : self?
    property right : self?

    def initialize(@val)
      @pri = @@r.get
      @min = T::MAX
      @lazy = T.zero
      @size = 1
      @rev = false
    end

    def push_up
      @size = left_size + right_size + 1
      @min = Math.min(val, Math.min(left_min, right_min))
      self
    end

    def inv!
      @rev = !rev
    end

    def push_down
      if rev
        @rev = false
        @left, @right = @right, @left
        @left.try &.inv!
        @right.try &.inv!
      end

      if lazy != T.zero
        left.try &.update(lazy)
        right.try &.update(lazy)
        @val += lazy
        @lazy = T.zero
      end

      push_up
    end

    def update(val : T)
      @lazy += val
      @min += val
    end

    def split(i : Int32)
      push_down
      key = left_size + 1

      if i < key
        fst, @left = left.try &.split(i) || nil_node_pair
        {fst, push_up}
      else
        @right, snd = right.try &.split(i - key) || nil_node_pair
        {push_up, snd}
      end
    end

    def insert(i : Int32, node : self) : self
      fst, snd = split(i)
      (fst.try &.merge(node) || node).merge(snd)
    end

    def merge(b : self?)
      return self if b.nil?

      push_down
      b.push_down

      if pri > b.pri
        @right = right.try &.merge(b) || b
        push_up
      else
        b.left = merge(b.left)
        b.push_up
      end
    end

    def delete(k : Int32)
      t1, t2 = split(k + 1)
      t1, t3 = t1.try &.split(k) || nil_node_pair
      t1.try &.merge(t2) || t2
    end

    # 部分木の先頭要素
    def first
      push_down
      left.try &.first || val
    end

    # 部分木の先頭要素
    def first_node
      push_down
      left.try &.first_node || self
    end

    {% for dir in %w(left right) %}
      {% for op, fb in {size: 0, min: "T::MAX", to_a: "[] of T"} %}
        @[AlwaysInline]
        private def {{dir.id}}_{{op.id}}
          {{dir.id}}.try &.{{op.id}} || {{fb.id}}
        end
      {% end %}
    {% end %}

    def nil_node
      nil.as(self?)
    end

    def nil_node_pair
      {nil_node, nil_node}
    end

    def inspect
      "(#{left.inspect} #{[val, min, lazy]} #{right.inspect})".gsub(/nil/, "")
    end

    def to_a
      left_to_a + [val] + right_to_a
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

  def initialize(a : Array(T))
    @root = nil_node
    a.each do |v|
      node = Node(T).new(v)
      @root = @root.try &.merge(node) || node
    end
  end

  def split(i : Int32)
    fst, snd = root.try &.split(i) || nil_node_pair
    {self.class.new(fst), self.class.new(snd)}
  end

  def insert(i : Int32, val : T)
    node = Node(T).new(val)
    @root = root.try &.insert(i, node) || node
  end

  def push(val)
    node = Node(T).new(val)
    @root = root.try &.merge(node) || node
  end

  def <<(val)
    push(val)
  end

  def merge(b : self)
    return self if b.root.nil?
    @root = root.try &.merge(b.root) || b.root
  end

  def delete(k : Int32)
    @root = root.try &.delete(k)
  end

  # 区間加算
  def add(lo : Int32, hi : Int32, v : T)
    t2, t3 = root.try &.split(hi) || nil_node_pair
    t1, t2 = t2.try &.split(lo) || nil_node_pair
    t2.try &.update(v)
    @root = t1.try &.merge(t2) || t2
    @root = root.try &.merge(t3) || t3
  end

  # 区間加算
  def []=(r : Rng, v : T)
    lo, hi = range_to_tuple(r)
    add(lo, hi, v)
  end

  # 区間最小
  def min(lo : Int32, hi : Int32)
    t2, t3 = root.try &.split(hi) || nil_node_pair
    t1, t2 = t2.try &.split(lo) || nil_node_pair
    ans = t2.try &.min
    @root = t1.try &.merge(t2) || t2
    @root = root.try &.merge(t3) || t3
    ans
  end

  # 区間最小
  def [](r : Rng)
    lo, hi = range_to_tuple(r)
    min(lo, hi)
  end

  # 区間反転
  def reverse(r : Rng)
    lo, hi = range_to_tuple(r)
    t2, t3 = root.try &.split(hi) || nil_node_pair
    t1, t2 = t2.try &.split(lo) || nil_node_pair
    t2.try &.inv!
    @root = t1.try &.merge(t2) || t2
    @root = root.try &.merge(t3) || t3
  end

  def reverse(lo : Int, hi : Int)
    reverse(lo...hi)
  end

  # 区間ローテート、先頭がmidになる
  def rotate(r : Rng, mid : Int)
    lo, hi = range_to_tuple(r)
    reverse(lo, hi)
    reverse(lo, lo + hi - mid)
    reverse(lo + hi - mid, hi)
  end

  # 先頭要素
  def first
    root.try &.first
  end

  # i番目の要素
  def at(i : Int)
    i += size if i < 0
    t1, t2 = root.try &.split(i) || nil_node_pair
    ans = t2.try &.first
    @root = t1.try &.merge(t2) || t2
    ans.not_nil!
  end

  # i番目の要素
  def [](i : Int)
    at(i)
  end

  # i番目の値を更新
  def []=(i : Int, v : T)
    i += size if i < 0
    t1, t2 = root.try &.split(i) || nil_node_pair
    t2.try &.first_node.try &.val=(v)
    @root = t1.try &.merge(t2) || t2
  end

  private def range_to_tuple(r : Rng)
    lo = r.begin || 0
    hi = (r.end || size - 1) + (r.excludes_end? ? 0 : 1)
    {lo, hi}
  end

  def nil_node
    nil.as(Node(T)?)
  end

  def nil_node_pair
    {nil_node, nil_node}
  end

  def size
    @root.try &.size || 0
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
