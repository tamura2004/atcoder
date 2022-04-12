# frozen_string_literal: true

class SplayTree
  include Enumerable

  UndefinedValue = Module.new

  # The default value for non existent key
  #
  # @api public
  attr_accessor :default

  # The default block for non existent key
  #
  # @api public
  attr_accessor :default_proc

  # Create a SplayTree
  #
  # @param [Object] default
  #   the default value for missing key
  #
  # @api public
  def initialize(default = UndefinedValue, &block)
    if !UndefinedValue.equal?(default) && block
      raise ArgumentError,
            "You need to pass either argument or a block as a default value"
    end
    @root = Node::EMPTY
    @subtree = Node.new(nil, nil)
    @default = default
    @default_proc = block
  end

  # @api public
  def empty?
    @root == Node::EMPTY
  end

  # @api public
  def size
    @root.size
  end

  alias length size

  # Iterate over each key & value pair in the tree
  #
  # @example
  #   tree = SplayTree.new
  #   tree.each { |key, val| ... }
  #
  # @yield [key, value]
  #
  # @yieldparam [Object] key
  # @yieldparam [Object] value
  #
  # @return [self]
  #
  # @api public
  def each(&block)
    if block_given?
      @root.each(&block)
      self
    else
      @root.to_enum
    end
  end

  # Iterate over each key in the tree
  #
  # @example
  #   tree = SplayTree.new
  #   tree.each_key { |key| ... }
  #
  # @yield [key]
  #
  # @yieldparam [Object] key
  #
  # @return [self]
  #
  # @api public
  def each_key(&block)
    if block_given?
      @root.each_key(&block)
      self
    else
      @root.to_enum(:each_key)
    end
  end

  # Iterate over each value in the tree
  #
  # @example
  #   tree = SplayTree.new
  #   tree.each_value { |val| ... }
  #
  # @yield [value]
  #
  # @yieldparam [Object] value
  #
  # @return [self]
  #
  # @api public
  def each_value(&block)
    if block_given?
      @root.each_value(&block)
      self
    else
      @root.to_enum(:each_value)
    end
  end

  # Return a new array of all the keys in the tree
  #
  # @return [Array[Object]]
  #
  # @api public
  def keys
    each_key.to_a
  end

  # Return a new array of all the values in the tree
  #
  # @return [Array[Object]]
  #
  # @api public
  def values
    each_value.to_a
  end

  # Insert a node into a tree with the given key and value
  # provided that the tree does not already contain the key.
  # The node becomes the root of the tree.
  #
  # @param [Object] key
  #   the key under which the node is inserted
  # @param [Object] value
  #   the value of the node inserted into the tree
  #
  # @return [Boolean]
  #   false if key already exists, true otherwise
  # @api public
  def []=(key, value)
    if @root.empty?
      @root = Node.new(key, value)
      return true
    end

    @root = @root.insert(key, value)

    splay(key)
  end

  alias insert []=

  # Find object by the key
  #
  # @param [Object] key
  #   the search key
  #
  # @api public
  def [](key)
    splay(key) unless @root.empty?

    return default_value if @root.key != key

    @root.value
  end

  alias fetch []

  # Check if tree contains a node with a matching key.
  #
  # @return [Boolean]
  #
  # @api public
  def key?(key)
    return false if @root.empty?

    splay(key)
    @root.key == key
  end

  # Delete a node specified by the key from the tree
  # given the tree contains a node with this key.
  # The deleted node value is returned. If the node
  # is not found a nil is returned.
  #
  # @param [Object] key
  #
  # @return [Object]
  #   the node's value under the key
  #
  # @api public
  def delete(key)
    return if empty?

    splay(key)
    return if @root.key != key

    deleted = @root
    right = @root.right
    @root = @root.left
    if @root.empty?
      @root = right
    else
      splay(key) # ensure empty right child
      @root.right = right
    end
    deleted.value
  end

  # Construct and return two trees t1 and t2, where
  # t1 contains items in t less than or equal to key,
  # and t2 contains all items in t greater than key.
  #
  # @param [Object] key
  #
  # @api public
  def split(key)
  end

  # Dump the tree structure in bracket format
  # (root left right)
  #
  # @return [String]
  #
  # @api public
  def dump
    @root.dump || ""
  end

  # Export tree as hash
  #
  # @return [Hash]
  #
  # @api public
  def to_hash
    each_with_object({}) { |(k, v), acc| acc[k] = v }
  end

  private

  # @api private
  def default_value
    if @default != UndefinedValue
      @default
    elsif @default_proc
      @default_proc.call
    end
  end

  # Top-down splaying by breaking down the tree.
  #
  # @param [Object] key
  #   the key at which to splay
  #
  # @api private
  def splay(key)
    current = @root
    dummy = left = right = @subtree
    @subtree.left = @subtree.right = Node::EMPTY
    loop do
      break if key == current.key

      if key < current.key
        break if current.left.empty?

        if key < current.left.key
          current = current.rotate_right
          break if current.left.empty?
        end
        right.left = current
        right = current
        current = current.left
      elsif key > current.key
        break if current.right.empty?

        if key > current.right.key
          current = current.rotate_left
          break if current.right.empty?
        end
        left.right = current
        left = current
        current = current.right
      end
    end
    left.right = current.left
    right.left = current.right
    current.left = dummy.right
    current.right = dummy.left
    @root = current
  end

  # A single tree node representation
  class Node
    include Comparable

    UndefinedValue = Module.new

    attr_reader :key

    attr_reader :value

    attr_accessor :left

    attr_accessor :right

    def initialize(key, value)
      @key, @value = key, value
      @left = @right = Node::EMPTY
    end

    # @api private
    def empty?
      false
    end

    # Number of nodes in this subtree
    #
    # @return [Integer]
    #
    # @api private
    def size
      left.size + 1 + right.size
    end

    # Compare node keys
    #
    # @return [Integer]
    #
    # @api private
    def <=>(other)
      @key <=> other.key
    end

    # Iterate over subtree nodes
    #
    # @api private
    def each(&block)
      @left.each(&block)
      yield [@key, @value]
      @right.each(&block)
    end

    # Iterate over subtree nodes
    #
    # @api private
    def each_key
      each { |k, _| yield k }
    end

    # Iterate over subtree nodes
    #
    # @api private
    def each_value
      each { |_, v| yield v }
    end

    # Dump the subtree structure starting from this node
    #
    # @return [String]
    #
    # @api private
    def dump
      left = @left.dump
      right = @right.dump
      if !@left.empty? || !@right.empty?
        "(" + [@key, left || "-", right || "-"].compact.join(" ") + ")"
      else
        @key || ""
      end
    end

    # Rotate right
    #
    #     Y         X
    #    / \       / \
    #   X   C  => A   Y
    #  / \           / \
    # A   B         B   C
    #
    # @api private
    def rotate_right
      tmp = @left
      @left = tmp.right
      tmp.right = self
      tmp
    end

    # Rotate left
    #
    #   Y            X
    #  / \          / \
    # A   X   =>   Y   C
    #    / \      / \
    #   B   C    A   B
    #
    # @api private
    def rotate_left
      tmp = @right
      @right = tmp.left
      tmp.left = self
      tmp
    end

    # Insert new root
    #
    # @api private
    def insert(key, value)
      case key <=> @key
      when -1
        @left = @left.insert(key, value)
        rotate_right
      when 0
        @value = value
        self
      when 1
        @right = @right.insert(key, value)
        rotate_left
      else
        raise TypeError, "Cannot compare: #{key} with #{@key}"
      end
    end

    class EmptyNode < Node
      def initialize(*)
      end

      def empty?
        true
      end

      def size
        0
      end

      def to_s; end

      def dump; end

      def each(&block); end

      def insert(key, value)
        Node.new(key, value)
      end
    end # EmptyNode

    EMPTY = Node::EmptyNode.new.freeze
  end # Node
end # SplayTree
