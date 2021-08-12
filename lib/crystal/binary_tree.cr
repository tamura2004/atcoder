class Treap
  class_getter none : Node = NilNode.new
  2.times { |i| @@none.ch[i] = @@none }

  getter root : Node

  def initialize
    @root = Treap.none
  end

  def [](i)
    root[i]
  end

  def insert(i, val)
    @root = root.insert(i, val, rand(1..200000))
  end

  def erase(i)
    @root = root.find_for_erase(i)
  end

  def insert(i, val, pri)
    @root = root.insert(i, val, pri)
  end

  def merge(other)
    node = Node.new(-1, Int32::MAX) 
    node.ch[0] = @root
    node.ch[1] = other.root
    @root = node.erase(root.cnt)
  end

  def debug
    puts "=== DEBUG ==="
    root.debug
  end

  class Node
    LEFT  = 0
    RIGHT = 1

    getter key : Int32
    getter pri : Int32
    getter cnt : Int32
    getter ch : StaticArray(self, 2)

    def initialize(@key, @pri)
      @cnt = 1
      @ch = StaticArray[Treap.none, Treap.none]
    end

    # ノードをi番目に挿入
    def insert(i, key, pri)
      x = ch[0].cnt
      b = i > x ? RIGHT : LEFT
      i -= x + 1 if b == RIGHT
      ch[b] = ch[b].insert(i, key, pri)
      update
      ch[b].pri > @pri ? rotate(b) : self
    end

    # 削除対象を探す
    def find_for_erase(i)
      x = ch[0].cnt
      if i == x
        b = ch[0].pri < ch[1].pri ? RIGHT : LEFT
        ret = rotate(b)
        ch[1-b].erase
        ret
      else
        b = i > x ? RIGHT : LEFT
        i -= x + 1 if b == RIGHT
        ch[b] = ch[b].find_for_erase(i)
        update
      end
    end
    
    def erase
      return Treap.none if ch.all?(&.pri.zero?)

      b = ch[0].pri < ch[1].pri ? RIGHT : LEFT
      ret = rotate(b)
      ch[1-b].erase
      ret
    end

    # i番目の要素
    def [](i)
      x = ch[0].cnt # 左部分木のノード数
      return key if i == x

      b = i > x ? RIGHT : LEFT
      i -= x + 1 if b == RIGHT
      ch[b][i]
    end

    # 部分木のノード数の更新
    def update
      @cnt = ch.sum(&.cnt) + 1
      self
    end

    # 木の回転
    def rotate(b)
      ret = ch[b]
      ch[b], ret.ch[1 - b] = ret.ch[1 - b], self
      update
      ret.update
    end

    def debug(indent = 0)
      ch[1].debug(indent + 2)
      printf("%s%d %d %d\n", " " * indent, key, pri, cnt)
      ch[0].debug(indent + 2)
    end
  end

  # 終端ノード
  class NilNode < Node
    def initialize
      @key = @pri = @cnt = 0
      none = uninitialized Node
      @ch = StaticArray[none, none]
    end

    def insert(i, val, pri)
      Node.new(val, pri)
    end

    def erase(i)
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
