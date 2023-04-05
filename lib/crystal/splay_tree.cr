class SplayTree(T)
  getter root : Node(T)?
  getter fxx : Proc(T, T, T)

  def initialize
    @root = nil.as(Node(T)?)
    @fxx = ->(x : T, y : T) { x + y }
  end

  def initialize(@root : Node(T)?)
    @fxx = ->(x : T, y : T) { x + y }
  end

  def initialize(@root : Node(T)?, &@fxx : Proc(T, T, T))
  end

  def initialize(v : T)
    @root = Node(T).new(v, fxx)
    @fxx = ->(x : T, y : T) { x + y }
  end

  def initialize(v : T, &@fxx : Proc(T, T, T))
    @root = Node(T).new(v, fxx)
  end

  # 自身を破壊的に左木に分割し右木を返す
  def split(v : T, eq = true) : SplayTree(T)
    root.try do |x|
      x, y = x.split(v, eq)
      @root = x
      SplayTree(T).new(y, &fxx)
    end || SplayTree(T).new(&fxx)
  end

  def |(v : T) : SplayTree(T)
    split(v, true)
  end

  def /(v : T) : SplayTree(T)
    split(v, false)
  end

  # 木の結合
  def merge(b : SplayTree(T)) : SplayTree(T)
    @root = root.try(&.merge(b.root)) || b.root
    self
  end

  def +(b : SplayTree)
    merge(b)
  end

  # 値の挿入
  def insert(v : T)
    hi = self | v
    self + SplayTree(T).new(v, &fxx) + hi
  end

  def <<(v : T)
    insert(v)
  end

  # 値の削除
  def delete(v : T)
    mid = self | v
    hi = mid / v
    self + hi
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
  getter tot : T?
  getter fxx : Proc(T?, T?, T?)

  def initialize(@val : T, f = Proc(T, T, T).new { |x, y| x + y })
    @fxx = ->(x : T?, y : T?) { x && y ? f.call(x, y) : x ? x : y ? y : nil }
    @ch = StaticArray(Node(T)?, 2).new { nil }
    @size = 1
    @tot = nil.as(T?)
  end

  # 回転
  def rot(i)
    ch[i].try do |x|
      ch[i] = x.ch[i ^ 1]
      x.ch[i ^ 1] = update
      x.update
    end || self
  end

  # 更新
  def update
    lo, hi = ch
    @size = lo && hi ? lo.size + hi.size : lo ? lo.size : hi ? hi.size : 0
    @tot = fxx.call(ch[0].try(&.tot), ch[1].try(&.tot))
    self
  end

  # 大小判定
  @[AlwaysInline]
  def dir(v)
    v <= val ? 0 : 1
  end

  # splay操作
  def splay(v : T)
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

  # 分割
  def split(v : T, eq = true)
    x = splay(v)
    if v < x.val || (v == x.val && eq)
      y = x.ch[0]
      x.ch[0] = nil
      {y, x.update}
    else
      y = x.ch[1]
      x.ch[1] = nil
      {x.update, y}
    end
  end

  # 以下と超えるで分割
  def /(v : T, eq = false)
    split(v, eq)
  end

  # 未満と以上で分割
  def |(v : T, eq = true)
    split(v, eq)
  end

  # 結合
  def merge(y : Node(T)?)
    x = splay(max.val)
    x.ch[1] = y
    x.update
  end

  # mergeのalias
  def +(y : Node(T)?)
    merge(y)
  end

  def <<(v : T)
    insert(v)
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
