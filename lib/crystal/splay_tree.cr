class Node
  getter lo : Node
  getter hi : Node
  getter up : Node
  getter v : String

  enum St
    Top
    Lo
    Hi
  end

  def initialize(@v)
    @lo = @hi = @up = NilNode.instance
  end

  def nil_node?
    false
  end

  def lo=(node)
    @lo, node.up = node, self
  end

  def hi=(node)
    @hi, node.up = node, self
  end

  def up=(node)
    @up = node
  end

  def state
    up.nil_node? ? St::Top : up.lo == self ? St::Lo : St::Hi
  end

  # rotate right = zig
  #
  #    |           |
  #   +--+        +--+
  #   |up|        |me|
  #   +--+        +--+
  #   /             \
  # +--+            +--+
  # |me|     =>     |up|
  # +--+            +--+
  #   \             /
  #   +--+        +--+
  #   |hi|        |hi|
  #   +--+        +--+
  #
  def zig
    if up = @up
      @up, up.up, hi.up, @hi, up.lo = up.up, self, up, up, hi
    end
  end

  # rotate left = zag
  #
  #  |             |
  # +--+          +--+
  # |up|          |me|
  # +--+          +--+
  #    \          /
  #   +--+      +--+
  #   |me|  =>  |up|
  #   +--+      +--+
  #    /          \
  # +--+          +--+
  # |lo|          |lo|
  # +--+          +--+
  #
  def zag
    if up = @up
      @up, up.up, lo.up, @lo, up.hi = up.up, self, up, up, lo
    end
  end

  def to_s(io)
    io << inspect
  end

  def inspect
    return "." if nil_node?
    "(#{v} #{lo} #{hi})"
  end
end

class NilNode < Node
  def self.instance
    @@instance ||= NilNode.new
  end

  def initialize
    @lo = uninitialized Node
    @hi = uninitialized Node
    @up = uninitialized Node
    @v = "."
    @lo = @hi = @up = self
  end

  def nil_node?
    true
  end

  def lo=(node)
  end

  def hi=(node)
  end

  def up=(node)
  end
end

class SplayTree
  getter root : Node

  def initialize(v)
    @root = Node.new(v)
  end
end
