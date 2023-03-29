class SplayTree(T)
  getter root : Node(T)?
  property multiset : Bool

  def initialize
    @root = nil.as(Node(T)?)
    @multiset = false
  end

  def insert(v : T)
    node = Node(T).new(v)
    root.try do |x|
      y = x.splay(v)
      i = y.dir(v)
      node.ch[i] = y.ch[i]
      y.ch[i] = nil
      node.ch[i^1] = y
    end
    @root = node
  end

  def <<(v : T)
    insert(v)
  end

  def to_s(io)
    io << root.to_s
  end
end

class Node(T)
  getter ch : StaticArray(Node(T)?, 2)
  getter val : T

  def initialize(@val : T)
    @ch = StaticArray(Node(T)?, 2).new { nil }
  end

  # b = 0 | left
  # b = 1 | right
  def rot(b)
    ch[b].try do |piv|
      ch[b] = piv.ch[b^1]
      piv.ch[b^1] = self
      piv
    end || self
  end

  @[AlwaysInline]
  def dir(v)
    v <= val ? 0 : 1
  end

  #      N
  #    i/ \
  #    X
  #  j/ \
  #  Y
  # / \
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
          ch[i] = x.rot(i^1)
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

  def minmax(b)
    b == 0 ? min : max
  end

  def to_s(io)
    io << "(#{ch[0]} #{val} #{ch[1]})"
  end    
end
