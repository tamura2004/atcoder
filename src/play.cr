class Right
  def each
    yield "right"
  end
end

class Left
  def each
    yield "left"
  end
end

class Node
  getter right : Right
  getter left : Left

  def initialize
    @right = Right.new
    @left = Left.new
  end

  def each
    @right.each do |node|
      yield node
    end
    yield "self"
    @left.each do |node|
      yield node
    end
  end
end

n = Node.new
n.each do |node|
  pp node
end

