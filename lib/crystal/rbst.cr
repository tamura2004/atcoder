struct Nil
  def count
    0
  end

  def sum
    0
  end
end

class Node
  property v : Int32
  property pri : Int32
  property cnt : Int32
  property sum : Int32
  property ch : Tuple(Node?,Node?)

  def initialize(@v)
    @pri = 0
    @cnt = 0
    @sum = 0
    @ch = {nil, nil}
  end

  def update
    @cnt = @ch.sum(&.cnt) + 1
    @sum = @ch.sum(&.sum) + v
  end
end
