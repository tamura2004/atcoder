class Node
  getter val : Int32
  getter cnt : Int32
  getter sum : Int32
  getter right : Node?
  getter left : Node?

  def initialize(@val)
    @cnt = 1
    @sum = val
    @left = @right = nil
  end
end
