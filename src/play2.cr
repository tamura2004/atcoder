class SplayTree
  class Node
    enum State
      Root
      Left
      Right
    end
    property! left : Node
    property! right : Node
    property! parent : Node

    def initialize
      @left = @right = @parent = NilNode.instance
    end

    def nil_node?
      false
    end

    def state
      return State::Root if parent.nil_node?
      return State::Left if parent.left == self
      State::Right
    end
  end

  class NilNode < Node
    def self.instance
      @@instance ||= NilNode.new
    end

    def initialize
      @left = @right = @parent = self
    end

    def nil_node?
      true
    end
  end
end

n1 = SplayTree::Node.new
n2 = SplayTree::Node.new
n3 = SplayTree::Node.new
n1.left = n2
n2.parent = n1
n1.right = n3
n3.parent = n1
pp n1.state.root?
pp n2.state
pp n3.state
