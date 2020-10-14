class Trie
  A = 27

  class Node
    getter value : Int32
    getter children : StaticArray(Node?,A)
    property tail : Bool

    def initialize(@value : Int32)
      @children = StaticArray(Node?,A).new(nil)
      @tail = false
    end
  end

  getter root : Node

  def initialize
    @root = Node.new(0)
  end

  def add(s : String)
    now = root
    s.chars.each do |c|
      i = num(c)
      if nex = now.children[i]
        now = nex
      else
        now = now.children[i] = Node.new(i)
      end
    end
    now.tail = true
  end

  def find(s : String)
    now = root
    s.chars.each do |c|
      i = num(c)
      if nex = now.children[i]
        now = nex
      else
        return false
      end
    end
    return now.tail
  end

  def num(c : Char)
    c.ord - 'a'.ord + 1
  end
end
;