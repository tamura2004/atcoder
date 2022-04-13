class Splaytree(K, V)
  class Node(K, V)
    getter key : K
    getter value : V?
    property left : Node(K, V)?
    property right : Node(K, V)?
    property parent : Node(K, V)?
    getter duplicates : Array(V?)

    def initialize(
      @key,
      @value = nil.as(V?),
      @parent = nil.as(Node(K, V)?),
      @left = nil.as(Node(K, V)?),
      @right = nil.as(Node(K, V)?)
    )
      @duplicates = [] of V?
    end

    def add_duplicate!(value)
      @duplicates.push(@value)
      @value = value
    end

    def remove_duplicate!
      return if @duplicates.empty?
      deleted = @value
      @value = @duplicates.pop
      deleted
    end

    def duplicates?
      !@duplicates.empty?
    end

    def root?
      parent.nil?
    end

    def parent_root?
      parent.try &.root?
    end

    def gparent
      parent.try &.parent
    end

    def set_left(node)
      @left = node
      return unless node
      node.parent = self
    end

    def set_right(node)
      @right = node
      return unless node
      node.parent = self
    end

    def rotate
      parent = self.parent
      gparent = self.gparent
      if gparent
        if parent.object_id == gparent.left.object_id
          gparent.set_left(self)
        else
          gparent.set_right(self)
        end
      else
        self.parent = nil
      end

      if object_id == parent.not_nil!.left.object_id
        parent.not_nil!.set_left(right)
        set_right(parent)
      else
        parent.not_nil!.set_right(left)
        set_left(parent)
      end
    end

    def zigzig?
      (object_id == parent.not_nil!.left.object_id && parent.object_id == gparent.not_nil!.left.object_id) ||
        (object_id == parent.not_nil!.right.object_id && parent.object_id == gparent.not_nil!.right.object_id)
    end

    def to_s
      key.to_s
    end

    def to_h
      {key => value}
    end

    def to_hash
      to_h
    end

    def to_a
      [key, value]
    end

    def <=>(other)
      return unless other
      key <=> other.key
    end
  end

  getter root : Node(K, V)?
  getter size : Int32

  def length
    size
  end

  def initialize
    @root = nil
    @size = 0
  end

  def empty?
    @root.nil?
  end

  def key?(key)
    !!get(key)
  end

  def higher(key)
    root.try do |root|
    # return if empty?
      get(key)
      return root.to_h if root.key > key
      get_one_higher_of_root
    end
  end

  def lower(key)
    return if empty?
    get(key)
    return @root.not_nil!.to_h if @root.not_nil!.key < key
    get_one_lower_of_root
  end

  def ceiling(key)
    return if empty?
    get(key)
    return @root.to_h if @root.key >= key
    get_one_higher_of_root
  end

  def floor(key)
    return if empty?
    get(key)
    return @root.to_h if @root.key <= key
    get_one_lower_of_root
  end

  def min
    return if empty?
    node = @root
    while node.left
      node = node.left
    end
    splay(node)
    node.to_h
  end

  def max
    return if empty?
    node = @root
    while node.right
      node = node.right
    end
    splay(node)
    node.to_h
  end

  def height
    subtree_height = uninitialized Proc(Node(K, V), Int32)
    subtree_height = ->(node : Node(K, V)) do
      return 0 unless node
      left = 1 + subtree_height.call(node.left)
      right = 1 + subtree_height.call(node.right)
      left > right ? left : right
    end
    subtree_height.call(@root)
  end

  def duplicates(key)
    return if empty?
    get(key)
    return if @root.key != key
    @root.duplicates + [@root.value]
  end

  def get(key)
    return if empty?
    node = @root
    value = nil
    loop do
      case key <=> node.not_nil!.key
      when 0
        value = node.not_nil!.value
        break
      when -1
        break if node.not_nil!.left.nil?
        node = node.not_nil!.left
      when 1
        break if node.not_nil!.right.nil?
        node = node.not_nil!.right
      else
        raise "Keys should be comparable!"
      end
    end
    splay(node)
    value
  end

  def [](key)
    get(key)
  end

  def insert(key, value)
    node = Node(K, V).new(key, value)
    if @root
      current = @root
      loop do
        case key <=> current.not_nil!.key
        when 0
          node = current
          node.not_nil!.add_duplicate!(value)
          break
        when -1
          unless current.not_nil!.left
            current.not_nil!.set_left(node)
            break
          end
          current = current.not_nil!.left
        when 1
          unless current.not_nil!.right
            current.not_nil!.set_right(node)
            break
          end
          current = current.not_nil!.right
        else
          raise "Keys should be comparable!"
        end
      end
    end
    splay(node)
    @size += 1
    true
  end

  def []=(key, value)
    insert(key, value)
  end

  def update(key, value)
    return false if empty?
    get(key)
    return false if @root.key != key
    @root.value = value
    true
  end

  def remove(key)
    return if empty?
    get(key)
    return if @root.key != key
    if @root.duplicates?
      deleted = @root.remove_duplicate!
    else
      deleted = @root.value
      if @root.left.nil?
        @root = @root.right
        @root.parent = nil
      else
        right = @root.right
        @root = @root.left
        @root.parent = nil
        get(key)
        @root.set_right(right)
      end
    end
    @size -= 1
    deleted
  end

  def clear
    @root = nil
    @size = 0
  end

  def each
    return if empty?
    stack = [] of Node(K, V)
    node = @root
    loop do
      if node
        stack.push(node)
        node.duplicates.each do |value|
          stack.push(Node(K, V).new(node.key, value, node))
        end
        node = node.left
      else
        break if stack.empty?
        node = stack.pop
        yield(node)
        node = node.right
      end
    end
  end

  def each_key
    each { |node| yield node.key }
  end

  def each_value
    each { |node| yield node.value }
  end

  def keys
    to_enum(:each_key).to_a
  end

  def values
    to_enum(:each_value).to_a
  end

  def display
    print_tree = uninitialized Proc(Node(K, V)?, Int32, Nil)
    print_tree = ->(node : Node(K, V)?, depth : Int32) do
      return unless node
      print_tree.call(node.right, depth + 1)
      puts node.key.to_s.rjust(5 * depth, ' ')
      print_tree.call(node.left, depth + 1)
    end
    print_tree.call(@root, 0)
  end

  def report
    return if empty?
    result = [] of NamedTuple(node: K, parent: K?, left: K?, right: K?)
    each do |node|
      item = {
        node:   node.key,
        parent: node.try &.parent.try &.key,
        left:   node.try &.left.try &.key,
        right:  node.try &.right.try &.key,
      }
      result << item
    end
    result
  end

  def get_one_higher_of_root
    return if @root.not_nil!.right.nil?
    node = @root.not_nil!.right
    while node.not_nil!.left
      node = node.not_nil!.left
    end
    splay(node)
    node.not_nil!.to_h
  end

  def get_one_lower_of_root
    root.try do |root|
      # return if @root.left.nil?
      node = root.left
      while node && node.right
        node = node.right
      end
      splay(node)
      node.try(&.to_h)
    end
  end

  def splay(node)
    until node.not_nil!.root?
      parent = node.not_nil!.parent
      if parent.not_nil!.root?
        node.not_nil!.rotate
      elsif node.not_nil!.zigzig?
        parent.not_nil!.rotate
        node.not_nil!.rotate
      else
        node.not_nil!.rotate
        node.not_nil!.rotate
      end
    end
    @root = node
  end
end

tr = Splaytree(Int32, Int32).new
10.times do |i|
  tr.insert(i, i ** 2)
end
10.times do
  tr[rand(10)]
end

tr.display
tr.report
pp tr.higher(5)
pp tr.lower(5)