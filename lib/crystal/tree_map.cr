# AVL木によるOrderedMap
class TreeMap(K, T)
  class Node(K, T)
    getter key : K
    getter val : T
    getter balance : Int32
    getter height : Int32
    getter size : Int32
    property left : Node(K, T)?
    property right : Node(K, T)?

    def initialize(@key, @val)
      @balance = 0
      @size = 1
      @height = 1
      @left = nil
      @right = nil
    end

    # 挿入
    def insert(k, v)
      # return self if v == val
      if k < key
        @left = left.try &.insert(k, v) || Node(K, T).new(k, v)
      else
        @right = right.try &.insert(k, v) || Node(K, T).new(k, v)
      end
      update.re_balance
    end

    def []=(k, v)
      insert(k, v)
    end

    # 削除
    def delete(k)
      if k == key
        left.try do |l|
          @left, node = l.pop
          node.left, node.right = left, right
          node.update.re_balance
        end || right.try do |r|
          right
        end || nil
      elsif k < key
        @left = left.try &.delete(k)
        update.re_balance
      else
        @right = right.try &.delete(k)
        update.re_balance
      end
    end

    # keyがk以下（未満）の最大値
    def lower(k, eq = true)
      if key < k || (eq && k == key)
        right.try(&.lower(k, eq)).try { |v| Math.max(v, val) } || val
      else
        left.try &.lower(k, eq)
      end
    end

    # v以上（超える）の最小値
    def upper(k, eq = true)
      if k < key || (eq && k == key)
        left.try(&.upper(k, eq)).try { |v| Math.min(v, val) } || val
      else
        right.try &.upper(k, eq)
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

    @[AlwaysInline]
    private def left_to_a
      left.try &.to_a || [] of T
    end

    @[AlwaysInline]
    private def right_to_a
      right.try &.to_a || [] of T
    end

    def inspect
      "(#{left.inspect} #{val} #{right.inspect})".gsub(/nil/, ".")
    end

    def to_a
      left_to_a + [val] + right_to_a
    end
  end

  getter root : Node(K, T)?

  def initialize(@root : Node(K, T)? = nil)
  end

  def insert(k, v)
    @root = root.try &.insert(k, v) || Node(K, T).new(k, v)
  end

  def []=(k, v)
    insert(k, v)
  end

  def delete(k)
    @root = root.try &.delete(k)
  end

  def lower(k, eq = true)
    @root.try &.lower(k, eq)
  end

  # v以上（より大きい）の最小値
  def upper(v, eq = true)
    @root.try &.upper(v, eq)
  end

  def size
    @root.try &.size || 0
  end

  def clear
    @root = nil
  end

  def inspect
    @root.inspect
  end

  def to_a
    @root.try &.to_a || [] of T
  end
end
