class SplayTree(K, V)
  class Node(K, V)
    property left : Node(K, V)?
    property right : Node(K, V)?
    getter size : Int64
    getter key : K
    getter val : V
    getter f : Proc(V, V, V)

    def initialize(
      @key,
      @val,
      @f : Proc(V, V, V) = Proc(V, V, V).new { |a, b| a + b }
    )
      @left = nil
      @right = nil
      @size = 0_i64
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

    def update
      @size = left_size + right_size
      @val = f.call(left_val, right_val)
      self
    end

    {% for dir in %w(left right) %}
      def {{dir.id}}_size
        {{dir.id}}.try &.size || 0_i64
      end

      def {{dir.id}}_val
        {{dir.id}}.try &.val || V.zero
      end
    {% end %}

    def insert(k, v)
      case k
      when .== key
        @val = v
        update
      when .< key
        @left = left.try &.insert(k, v) || Node(K, V).new(k, v)
        rotate_right
      when .> key
        @right = right.try &.insert(k, v) || Node(K, V).new(k, v)
        rotate_left
      end
    end

    def find(k)
      case k
      when .== key
        self
      when .< key
        left.try &.find(k) && rotate_right
      when .> key
        right.try &.find(k) && rotate_left
      end
    end

    def inspect
      "(#{left.inspect} #{key}:#{val} #{right.inspect})"
    end
  end

  getter root : Node(K, V)?

  def initialize
    @root = nil
  end

  def insert(k, v)
    @root = root.try &.insert(k, v) || Node(K, V).new(k, v)
  end

  def inspect
    root.inspect
  end

  def find(k)
    @root = root.try &.find(k) || root
  end
end

st = SplayTree(Int32, Int32).new
st.insert(1, 5)
st.insert(2, 4)
st.insert(3, 3)
st.insert(4, 2)
st.insert(5, 1)
pp st.find(3)
pp st
