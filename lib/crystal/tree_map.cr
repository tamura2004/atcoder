# AVL木によるOrderedMap
class TreeMap(K, T)
  class Node(K, T)
    getter key : K
    getter lo : K
    getter hi : K
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
      @lo = key
      @hi = key
    end

    # 値の更新または新規ノードの追加
    def upsert(k, v) : self
      if k == key
        @val = v
      elsif k < key
        @left = left.try &.upsert(k, v) || self.class.new(k, v)
      else
        @right = right.try &.upsert(k, v) || self.class.new(k, v)
      end
      update.re_balance
    end

    def []=(k, v) : self
      upsert(k, v)
    end

    # 削除
    def delete(k) : self
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

    # k以下（未満）の最大のキー
    def lower_key(k, eq = false) : K?
      if k < key || (eq && k == key)
        left.try &.lower_key(k, eq)
      else
        right.try &.lower_key(k, eq) || key
      end
    end

    # v以上（超える）の最小のキー
    def upper_key(k, eq = true) : K?
      if k < key || (eq && k == key)
        left.try &.upper_key(k, eq) || key
      else
        right.try &.upper_key(k, eq)
      end
    end

    # ノードの状態を更新
    def update : self
      @height = Math.max(left_height, right_height) + 1
      @balance = left_height - right_height
      @size = left_size + right_size + 1
      @lo = left.try &.lo || key
      @hi = right.try &.hi || key
      self
    end

    # 回転によりバランスを保つ
    def re_balance : self
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
    def rotate_left : self
      right.try do |root|
        root.tap do
          @right, root.left = root.left, self
          root.update
          update
        end
      end || self
    end

    # 右回転
    def rotate_right : self
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
    private def left_size : Int32
      left.try &.size || 0
    end

    @[AlwaysInline]
    private def right_size : Int32
      right.try &.size || 0
    end

    @[AlwaysInline]
    private def left_height : Int32
      left.try &.height || 0
    end

    @[AlwaysInline]
    private def right_height : Int32
      right.try &.height || 0
    end

    @[AlwaysInline]
    private def left_balance : Int32
      left.try &.balance || 0
    end

    @[AlwaysInline]
    private def right_balance : Int32
      right.try &.balance || 0
    end

    @[AlwaysInline]
    private def left_to_a : Array(T)
      left.try &.to_a || [] of T
    end

    @[AlwaysInline]
    private def right_to_a : Array(T)
      right.try &.to_a || [] of T
    end

    def inspect : String
      "(#{left.inspect} #{[key, lo, hi]} #{right.inspect})".gsub(/nil/, ".")
    end

    def to_a : Array(T)
      left_to_a + [val] + right_to_a
    end
  end

  getter root : Node(K, T)?

  def initialize(@root : Node(K, T)? = nil)
  end

  def upsert(k, v)
    @root = root.try &.upsert(k, v) || Node(K, T).new(k, v)
  end

  def []=(k, v)
    upsert(k, v)
  end

  # def find(k)
  #   @root = root.try &.find(k)
  # end

  def delete(k)
    @root = root.try &.delete(k)
  end

  # `k`以下（未満）の最大のキー
  def lower_key(k, eq = true) : K?
    @root.try &.lower_key(k, eq)
  end

  # `k`以上（越える）最小のキー
  def upper_key(k, eq = true) : K?
    @root.try &.upper_key(k, eq)
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
