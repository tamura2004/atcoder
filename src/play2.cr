class Node
  @lo : Node
  @hi : Node

  def initialize
    @lo = @hi = NilNode.instance
  end

  def nil_node?
    false
  end
end

class NilNode < Node
  def self.instance
    @@instance ||= NilNode.new
  end

  def initialize
    @lo = uninitialized Node
    @hi = uninitialized Node
    @lo = @hi = self
  end

  def nil_node?
    true
  end
end

n = Node.new
pp n