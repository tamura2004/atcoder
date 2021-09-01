class Node(T)
  property val : T?
  @cnt : Int32

  def initialize
    @val = nil
    @cnt = 10
  end

  def cnt
    val ? @cnt : 0
  end
end

n = Node(Int64).new
pp n.cnt
n.val = 10
pp n.cnt
