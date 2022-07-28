class PersistentArray(T)
  class Node(T)
    property left : Node(T)?
    property right : Node(T)?
    property val : T

    def initialize(@val = T.zero, @left = nil, @right = nil)
    end

    def inspect
      "(#{left.inspect} #{val} #{right.inspect})".gsub(/nil/, "")
    end
  end

  getter root : Node(T)?
  getter h : Int32
  getter default : Proc(Int32, T)

  def initialize(
    @h = 20,
    @root = nil.as(Node(T)?),
    @default = Proc(Int32,T).new{|i| T.new(i) }
  )
  end

  # 参照
  def [](i)
    get(root, i, h)
  end

  def get(node : Node(T)?, i, d)
    return default.call(i) if node.nil?
    return node.val if d.zero?

    if i.bit(d - 1).zero?
      get(node.left, i, d - 1)
    else
      get(node.right, i, d - 1)
    end
  end

  # 非破壊更新
  def update(i, v)
    nex_root = update(root.try(&.dup) || Node(T).new, root, i, v, h)
    PersistentArray(T).new(h, nex_root)
  end

  def update(node, old_node, i, v, d)
    if d.zero?
      node.val = v
    elsif i.bit(d - 1).zero?
      old_node_left = old_node.try(&.left)
      new_node_left = old_node_left.try(&.dup) || Node(T).new
      node.left = update(new_node_left, old_node_left, i, v, d - 1)
    else
      old_node_right = old_node.try(&.right)
      new_node_right = old_node_right.try(&.dup) || Node(T).new
      node.right = update(new_node_right, old_node_right, i, v, d - 1)
    end
    node
  end

  # 破壊的代入
  def []=(i, v)
    set(i, v)
  end
  
  def set(i, v)
    set(@root = root || Node(T).new, i, v, h)
  end

  # 破壊的代入
  def set(node, i, v, d)
    if d.zero?
      node.val = v
    elsif i.bit(d - 1).zero?
      set(node.left = node.try(&.left) || Node(T).new, i, v, d - 1)
    else
      set(node.right = node.try(&.right) || Node(T).new, i, v, d - 1)
    end
    v
  end
end

