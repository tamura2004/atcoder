# AVL木によるOrderedSet
class AVLTree(T)
  getter root : Node(T)?

  def initialize(@root : Node(T)? = nil)
  end

  def insert(v : T)
    @root = root.try &.insert(v) || Node(T).new(v)
  end

  def <<(v : T)
    insert(v)
  end

  def delete(v : T)
    @root = root.try &.delete(v)
  end

  # v以下（未満）の最大値
  #
  # ```
  # tr = [1, 3, 5, 7].to_ordered_set
  # tr.lower(4)            # => 3
  # tr.lower(5)            # => 5
  # tr.lower(5, eq: false) # => 3
  # ```
  def lower(v, eq = true)
    @root.try &.lower(v, eq)
  end

  def lower_index(v, eq = true)
    @root.try &.lower_index(v, eq)
  end

  # v以下（未満）の要素数
  def lower_count(v, eq = true)
    @root.try(&.lower_index(v, eq)).try(&.succ) || 0
  end

  # v以上（超える）の最小値
  def upper(v, eq = true)
    @root.try &.upper(v, eq)
  end

  def upper_index(v, eq = true)
    @root.try &.upper_index(v, eq)
  end

  # v以上（を超える）要素数
  def upper_count(v, eq = true)
    @root.try(&.upper_index(v, eq)).try{ |v| (@root.try(&.size) || 0) - v} || 0
  end

  # 最小の値を持つノード
  def min_node
    @root.try &.min_node
  end

  # 最小の値
  def min
    @root.try &.min
  end

  # 最大の値を持つノード
  def max_node
    @root.try &.max_node
  end

  # 最大の値
  def max
    @root.try &.max
  end

  def pop
    @root, node = root.try &.pop || {nil.as(Node(T)?), nil.as(Node(T)?)}
    node
  end

  # 小さいほうからk番目のノードの値(0-origin)
  def at(k)
    @root.try &.at(k)
  end

  def [](k)
    at(k)
  end

  def size
    @root.try &.size || 0
  end

  def inspect
    @root.inspect
  end

  def debug
    @root.try &.debug(0)
  end

  class Node(T)
    getter val : T
    getter balance : Int32
    getter height : Int32
    getter size : Int32
    property left : Node(T)?
    property right : Node(T)?

    def initialize(@val)
      @balance = 0
      @size = 1
      @height = 1
      @left = nil
      @right = nil
    end

    # 挿入
    def insert(v)
      # return self if v == val
      if v < val
        @left = left.try &.insert(v) || Node(T).new(v)
      else
        @right = right.try &.insert(v) || Node(T).new(v)
      end
      update
      re_balance
    end

    # 削除
    def delete(v)
      if v == val
        left.try do |l|
          @left, node = l.pop
          node.left, node.right = left, right
          node.update.re_balance
        end || right.try do |r|
          right
        end || nil
      elsif v < val
        @left = left.try &.delete(v)
        update.re_balance
      else
        @right = right.try &.delete(v)
        update.re_balance
      end
    end

    # v以下（未満）の最大値
    def lower(v, eq = true)
      if val < v || (eq && v == val)
        right.try(&.lower(v, eq)).try { |v| Math.max(v, val) } || val
      else
        left.try &.lower(v, eq)
      end
    end

    # v以下（未満）の最大のインデックス
    def lower_index(v, eq = true)
      pos = left_size
      if val < v || (eq && v == val)
        right.try(&.lower_index(v, eq)).try(&.+(pos + 1)) || pos
      else
        left.try(&.lower_index(v, eq))
      end
    end

    # v以上（超える）の最小値
    def upper(v, eq = true)
      if v < val || (eq && v == val)
        left.try(&.upper(v, eq)).try { |v| Math.min(v, val) } || val
      else
        right.try &.upper(v, eq)
      end
    end

    # v以上（超える）の最小のインデックス
    def upper_index(v, eq = true)
      pos = left_size
      if val > v || (eq && v == val)
        left.try(&.upper_index(v, eq)) || pos
      else
        right.try(&.upper_index(v, eq)).try(&.+(pos + 1))
      end
    end

    # 最大値を削除して返す
    def pop
      right.try do |r|
        @right, node = r.pop
        {update, node}
      end || {left, self}
    end

    # 最小のノード
    def min_node
      left.try &.min_node || self
    end

    # 最小の値
    def min
      min_node.try &.val
    end

    # 最大のノード
    def max_node
      right.try &.max_node || self
    end

    # 最大の値
    def max
      max_node.try &.val
    end

    # 小さいほうからk番目のノードの値(0-origin)
    def at(k)
      ord = left.try &.size || 0
      if k == ord
        val
      elsif k < ord
        left.try &.at(k)
      else
        right.try &.at(k - ord - 1)
      end
    end

    # ノードの状態を更新
    def update
      @height = Math.max(left_height, right_height) + 1
      @balance = left_height - right_height
      @size = left_size + right_size + 1
      self
    end

    # 回転によりバランスを保つ
    def re_balance
      case balance
      when 2..
        if left_balance < 0
          @left = left.try &.rotate_left.update
        end
        rotate_right.update
      when ..-2
        if right_balance > 0
          @right = right.try &.rotate_right.update
        end
        rotate_left.update
      else
        self
      end
    end

    # 左回転
    def rotate_left
      right.try do |root|
        root.tap do
          @right, root.left = root.left, self
          root.update
          update
        end
      end || self
    end

    # 右回転
    def rotate_right
      left.try do |root|
        root.tap do
          @left, root.right = root.right, self
          root.update
          update
        end
      end || self
    end

    @[AlwaysInline]
    def [](k)
      at(k)
    end

    @[AlwaysInline]
    private def left_size
      left.try &.size || 0
    end

    @[AlwaysInline]
    private def right_size
      right.try &.size || 0
    end

    @[AlwaysInline]
    private def left_height
      left.try &.height || 0
    end

    @[AlwaysInline]
    private def right_height
      right.try &.height || 0
    end

    @[AlwaysInline]
    private def left_balance
      left.try &.balance || 0
    end

    @[AlwaysInline]
    private def right_balance
      right.try &.balance || 0
    end

    def inspect
      # "(#{val} #{left.inspect} #{right.inspect})".gsub(/nil/, ".")
      "(#{left.inspect} #{val} #{right.inspect})".gsub(/nil/, ".")
      # "(#{left.inspect} #{[val, size, height, balance]} #{right.inspect})".gsub(/nil/, ".")
    end

    def debug(indent = 0)
      left.try &.debug(indent + 2)
      puts " " * indent + "#{val}[#{size},#{height},#{balance}]"
      right.try &.debug(indent + 2)
    end
  end
end

module Indexable(T)
  def to_ordered_set
    AVLTree(T).new.tap do |tr|
      each do |v|
        tr << v
      end
    end
  end
end

alias OrderedSet = AVLTree
