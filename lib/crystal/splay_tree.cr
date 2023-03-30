class SplayTree(T)
  getter root : Node(T)?
  property multiset : Bool

  def initialize
    @root = nil.as(Node(T)?)
    @multiset = false
  end

  def initialize(@root : Node(T)?)
    @multiset = false
  end

  def split(v : T, eq = true)
    splay(v).try do |x|
      x.rot(0) if v < x.val || (v == x.val && !eq)
      if v < x.val || (v == x.val && !eq)
        @root = nil
        SplayTree(T).new(x)
      else
        y = x.ch[1]
        x.ch[1] = nil
        @root = x.update
        SplayTree(T).new(y)
      end
    end || SplayTree(T).new
  end

  def |(v : T, eq = true)
    split(v, eq)
  end

  def to_s(io)
    io << root.to_s
  end

  def splay(v : T)
    @root = root.try &.splay(v)
  end

  def rot(i)
    @root = root.try &.rot(i)
  end

  def to_a
    root.try &.to_a || [] of T
  end

  def size
    root.try &.size || 0
  end
end

class Node(T)
  getter ch : StaticArray(Node(T)?, 2)
  getter val : T
  getter size : Int32

  def initialize(@val : T)
    @ch = StaticArray(Node(T)?, 2).new { nil }
    @size = 1
  end

  # 回転
  def rot(i)
    ch[i].try do |x|
      ch[i] = x.ch[i ^ 1]
      x.ch[i ^ 1] = update
      x.update
    end || self
  end

  def update
    @size = ch.sum { |c| c.try(&.size) || 0 }.succ
    self
  end

  @[AlwaysInline]
  def dir(v)
    v <= val ? 0 : 1
  end

  # splay操作
  def splay(v)
    return self if v == val
    i = dir(v)
    ch[i].try do |x|
      # zig
      return rot(i) if v == x.val
      j = x.dir(v)
      x.ch[j].try do |y|
        x.ch[j] = y.splay(v)
        if i == j
          # zig-zig
          rot(i).rot(i)
        else
          # zig-zag
          ch[i] = x.rot(i ^ 1)
          rot(i)
        end
      end || rot(i)
    end || self
  end

  def min
    ch[0].try do |x|
      x.min
    end || self
  end

  def max
    ch[1].try do |x|
      x.max
    end || self
  end

  def minmax(i)
    i == 0 ? min : max
  end

  def to_s(io)
    io << "(#{ch[0]} #{val} #{ch[1]})"
  end

  def to_a
    (ch[0].try &.to_a || [] of T) + [val] + (ch[1].try &.to_a || [] of T)
  end
end
