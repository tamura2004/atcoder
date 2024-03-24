class Node
  getter val : Int64
  property left : self?
  property right : self?

  def initialize(@val)
    @left = nil.as(self?)
    @right = nil.as(self?)
  end

  def <<(other : Node)
    right.try do |right|
      right.left = other
      other.right = right
    end
    @right = other
    other.left = self
  end

  def delete
    left.try do |left|
      left.right = right
    end
    right.try do |right|
      right.left = left
    end
  end
end

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
nodes = a.map{|v|Node.new(v)}
node = a.zip(nodes).to_h
head = Node.new(Int64::MIN)
head << nodes[0]

nodes.each_cons_pair do |left, right|
  left << right
end

q = gets.to_s.to_i64
q.times do
  cmd, x, y = gets.to_s.split.map(&.to_i64) + [-1_i64]
  case cmd
  when 1
    new_node = Node.new(y)
    node[y] = new_node
    node[x] << node[y]
  when 2
    node[x].delete
  end
end

ans = [] of Int64
v = head.right
while !v.nil?
  ans << v.val
  v = v.right
end
puts ans.join(" ")
