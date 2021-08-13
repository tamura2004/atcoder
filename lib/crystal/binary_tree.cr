class Treap
  class_getter nil_node : Node = NilNode.new
  2.times { |i| @@nil_node.ch[i] = @@nil_node }

  getter root : Node

  def initialize
    @root = Treap.nil_node
  end

  def initialize(@root)
  end

  def [](i)
    root[i]
  end

  # i番目に値val優先度priのノードを挿入
  def insert(i, val, pri)
    @root = root.insert(i, val, pri)
  end

  # i番目に値valのノードを挿入
  def insert(i, val)
    @root = root.insert(i, val, rand(1..200000))
  end

  # 末尾に値valのノードを挿入
  def <<(val)
    @root = root.insert(root.cnt, val, rand(1..200000))
  end

  # i番目のノードの部分木を処理
  def find(i, &block : Node -> Node)
    @root = root.find(i, &block)
  end

  # i番目のノードを削除
  def erase(i)
    @root = root.erase(i)
  end

  # ２つの木を統合
  def merge(other)
    node = Node.new(-1, Int32::MAX)
    node.ch[0] = @root
    node.ch[1] = other.root
    node.update
    @root = node.erase(root.cnt)
  end

  # 木の分割
  def split(i)
    insert i, -1, Int32::MAX
    left, right = root.ch
    {Treap.new(left), Treap.new(right)}
  end

  def debug
    puts "=== DEBUG ==="
    root.debug
  end

  class Node
    LEFT  = 0
    RIGHT = 1

    getter val : Int64
    getter pri : Int32
    getter cnt : Int32
    getter ch : StaticArray(self, 2)

    def initialize(val, @pri)
      @val = val.to_i64
      @cnt = 1
      @ch = StaticArray[Treap.nil_node, Treap.nil_node]
    end

    def nil_node?
      false
    end

    # k番目の要素を探す
    # *dir*: 次の部分木
    # *k*: 部分木内の順番
    # *just*: 現在のノードがk番目である
    private def nex(k)
      x = ch[0].cnt # 左の部分木の要素数
      just : Bool = x == k
      dir = k > x ? RIGHT : LEFT
      k -= x + 1 if dir == RIGHT
      {dir, k, just}
    end

    # ノードをi番目に挿入
    def insert(i, val, pri) : Node
      b, i = nex(i)
      ch[b] = ch[b].insert(i, val, pri)
      update
      ch[b].pri > @pri ? rotate(b) : self
    end

    # i番目のノード
    def [](i)
      b, i, just = nex(i)
      return self if just
      ch[b][i]
    end

    # i番目のノードを探して削除
    def find(i, &block : Node -> Node)
      b, i, just = nex(i)

      if just
        block.call(self)
      else
        ch[b] = ch[b].find(i, &block)
        update
      end
    end

    # i番目のノードを探して削除
    def erase(i) : Node
      b, i, just = nex(i)

      if just
        _erase.update
      else
        ch[b] = ch[b].erase(i)
        update
      end
    end

    # i番目のノードを削除
    def _erase : Node
      b = ch[0].pri < ch[1].pri ? RIGHT : LEFT
      rotate(b).tap do |node|
        next if node.nil_node?
        node.ch[1 - b] = node.ch[1 - b]._erase
        node.update
      end
    end

    # 部分木のノード数の更新
    def update
      @cnt = ch.sum(&.cnt) + 1
      self
    end

    # 木の回転
    def rotate(b) : Node
      ch[b].tap do |node|
        next if node.nil_node?
        ch[b], node.ch[1 - b] = node.ch[1 - b], self
        update
        node.update
      end
    end

    def debug(indent = 0)
      ch[1].debug(indent + 2)
      printf("%sv:%d p:%d c:%d\n", " " * indent, val, pri, cnt)
      ch[0].debug(indent + 2)
    end
  end

  # 終端ノード
  class NilNode < Node
    def initialize
      @val = 0_i64
      @pri = @cnt = 0
      nil_node = uninitialized Node
      @ch = StaticArray[nil_node, nil_node]
    end

    def nil_node?
      true
    end

    def insert(i, val, pri)
      Node.new(val, pri)
    end

    def find(i, &block : Node -> Node)
      self
    end

    def erase(i)
      self
    end

    def _erase
      self
    end

    def update
      self
    end

    def rotate(b)
      self
    end

    def debug(indent = 0)
      puts " " * indent + "nil"
    end
  end
end
