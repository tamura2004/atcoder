class Node(T)
  property lch : Node(T) | NilNode(T).class
  property rch : Node(T) | NilNode(T).class
  getter val : T

  def initialize(@val : T)
    @lch = @rch = NilNode(T)
  end

  def insert(v)
    if v < val
      @lch = lch.insert(v)
    else
      @rch = rch.insert(v)
    end
  end

  def <<(v)
    insert(v)
  end

  #     y          X
  #    / \        / \
  #   X   C  ->  A   Y
  #  / \            / \
  # A   B          B   C
  def rot_r
    lch.rch, @lch = self, lch.rch
  end

  def rot_l
    rch.lch, @rch = self, rch.lch
  end
end

class NilNode(T)
  def self.insert(v)
    Node.new(v)
  end

  {% for op in %w(rch lch) %}
    def self.{{op.id}}; self; end
    def self.{{op.id}}=(v); end
  {% end %}
end

root = Node.new(20)
root << 10
root << 30
root.rot_r
pp root
