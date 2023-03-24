enum St
  Top
  Lo
  Hi
end

class Node(K)
  property lo : Node(K) | NilNode(K).class
  property hi : Node(K) | NilNode(K).class
  property up : Node(K) | NilNode(K).class
  getter v : K


  def initialize(@v)
    @lo = @hi = @up = NilNode(K)
  end

  def nil_node?
    false
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
    up.up, hi.up, up.lo, @hi, @up = self, up, hi, up, up.up
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
    up.up, lo.up, up.hi, @lo, @up = self, up, lo, up, up.up
  end

  def to_s(io)
    io << inspect
  end

  def inspect
    return "." if nil_node?
    "(#{v} #{lo} #{hi})"
  end
end

class NilNode(K)
  def self.v
    K.zero
  end

  {% for op in %w(up lo hi) %}
    def self.{{op.id}}; self; end
    def self.{{op.id}}=(v); end
  {% end %}

  def self.inspect
    "."
  end

  def self.to_s(io)
    io << inspect
  end

  def self.state
    St::Top
  end

  def self.nil_node?
    true
  end
end

class SplayTree(K)
  getter root : Node(K)

  def initialize(v)
    @root = Node(K).new(v)
  end
end

class String
  def self.zero
    "."
  end
end
