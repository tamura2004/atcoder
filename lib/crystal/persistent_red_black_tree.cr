class PersystentRedBlackTree(T)
  enum Color
    Red
    Black
  end

  class Node(T)
    getter color : Color
    getter size : Int32
    getter rank : Int32
    getter val : T?
    getter left : Node(T)?
    getter right : Node(T)?

    def initialize(@val)
      @color = Color::Black
      @size = 1
      @rank = 0
      @left = nil
      @right = nil
    end

    def initialize(@left, @right, @color)
      @size = (left.try(&.size) || 0) + (right.try(&.size) || 0)
      @rank = (left.try(&.rank) || 0) + left.color.value
      @val = nil
    end
  end
end
