# AVL木によるOrderedMap
class TreeMap(K, V)
  class Node(K, V)
    getter key : K
    getter lo : K
    getter hi : K
    getter val : V
    getter acc : V?
    getter fxx : Proc(V?, V?, V?)
    getter balance : Int32
    getter height : Int32
    getter size : Int32
    property left : Node(K, V)?
    property right : Node(K, V)?

    def initialize(@key, @val, @fxx)
      @balance = 0
      @size = 1
      @height = 1
      @left = nil
      @right = nil
      @lo = key
      @hi = key
      @acc = val
    end

    # 値の更新または新規ノードの追加
    def upsert(k : K, v : V) : self
      if k == key
        @val = v
      elsif k < key
        @left = left.try &.upsert(k, v) || self.class.new(k, v, @fxx)
      else
        @right = right.try &.upsert(k, v) || self.class.new(k, v, @fxx)
      end
      update.re_balance
    end

    def []=(k, v) : self
      upsert(k, v)
    end

    def []?(k : K) : V?
      if k == key
        val
      elsif k < key
        left.try &.[k]?
      else
        right.try &.[k]?
      end
    end

    def [](k : K) : V
      self[k]?.not_nil!
    end

    # 削除
    def delete(k : K) : self?
      if k == key
        case {left, right}
        when {Nil, Nil} then nil
        when {_, Nil}   then left
        when {Nil, _}   then right
        else
          node = left.not_nil!.max_node
          @left = left.not_nil!.delete(node.key)
          node.left = @left
          node.right = @right
          node.update.re_balance
        end
      elsif k < key
        @left = left.try &.delete(k)
        update.re_balance
      else
        @right = right.try &.delete(k)
        update.re_balance
      end
    end

    # 最大のキーを持つノード
    def max_node : self
      right.try &.max_node || self
    end

    # k以下（未満）の最大のキー
    def lower_key(k : K, eq = false) : K?
      if key < k || (eq && key == k)
        right.try &.lower_key(k, eq) || key
      else
        left.try &.lower_key(k, eq)
      end
    end

    # v以上（超える）の最小のキー
    def upper_key(k : K, eq = true) : K?
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
      @acc = fxx.call(fxx.call(left_val, val), right_val)
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
    private def left_val : V?
      left.try &.val
    end

    @[AlwaysInline]
    private def right_val : V?
      right.try &.val
    end

    @[AlwaysInline]
    private def left_to_a : Array({K, V})
      left.try &.to_a || [] of Tuple(K, V)
    end

    @[AlwaysInline]
    private def right_to_a : Array({K, V})
      right.try &.to_a || [] of Tuple(K, V)
    end

    def inspect : String
      "(#{key} #{left.inspect} #{right.inspect})".gsub(/nil/, ".")
    end

    def to_a : Array({K, V})
      left_to_a + [{key, val}] + right_to_a
    end
  end

  getter root : Node(K, V)?
  getter fxx : Proc(V?, V?, V?)

  def initialize(@root : Node(K, V)? = nil, fxx : Proc(V, V, V) = ->(x : V, y : V) { y })
    @fxx = ->(x : V?, y : V?) { x && y ? fxx.call(x, y) : x ? x : y }
  end

  def upsert(k : K, v : V)
    @root = root.try &.upsert(k, v) || Node(K, V).new(k, v, fxx)
  end

  # `k`をキーとする値をセット（なければノード追加）
  def []=(k : K, v : V)
    upsert(k, v)
  end

  # `k`をキーに持つ値を返す（無ければnil）
  def []?(k : K) : V?
    root.try &.[k]?
  end

  # `k`をキーに持つ値を返す（無ければ例外）
  def [](k : K) : V
    root.not_nil![k]
  end

  # `k`をキーに持つ値を削除
  def delete(k : K)
    @root = root.try &.delete(k)
  end

  # `k`未満（以下）の最大のキー
  def lower_key(k : K, eq = false) : K?
    @root.try &.lower_key(k, eq)
  end

  # `k`以上（越える）最小のキー
  def upper_key(k : K, eq = true) : K?
    @root.try &.upper_key(k, eq)
  end

  def size : Int32
    @root.try &.size || 0
  end

  def clear
    @root = nil
  end

  def inspect : String
    @root.inspect
  end

  def to_a : Array({K, V})
    @root.try &.to_a || [] of Tuple(K, V)
  end
end
