class Treap
  class Node
    getter val : Int32
    getter pri : Int32
    getter cnt : Int32
    getter sum : Int32
    property ch : Array(Node?)

    Left  = 0
    Right = 1
    Both  = 2
    None  = 3

    def initialize(@val)
      @cnt = 1
      @sum = val
      @pri = (val - 5).abs
      @ch = Array(Node?).new(2, nil)
    end

    def insert(x)
      b = dir(x)
      ch[b] = ch[b].try(&.insert(x)) || Node.new(x)

      if t = ch[b]
        if t.pri < pri
          rotate(b)
        else
          update!
        end
      end
    end

    def erace(x)
      if x != val
        b = dir(x)
        ch[b] = ch[b].try(&.erace(x))
        update!
      else
        l, r = ch
        if l.nil? && r.nil?
          nil
        else
          b = r.nil? ? Left : l.nil? ? Right : l.pri < r.pri ? Left : Right
          rotate(b).tap do |t|
            t.ch[1 - b] = erace(x)
          end
        end
      end
    end

    def rotate(b) : Node
      case t = ch[b]
      when Nil
        update!
      when Node
        @ch[b], t.ch[1 - b] = t.ch[1 - b], self
        update!
        t.update!
      else
        raise "error"
      end
    end

    def update!
      @cnt = ch.sum { |t| t.try(&.cnt) || 0 } + 1
      @sum = ch.sum { |t| t.try(&.sum) || 0 } + val
      self
    end

    private def dir(x)
      x < val ? Left : Right
    end

    def debug(i)
      printf("%s%d:%d:%d:%d\n", " " * i, val, pri, cnt, sum)
      @ch.each do |t|
        next if t.nil?
        t.debug(i + 2)
      end
    end
  end

  getter root : Node?

  def initialize
    @root = nil
  end

  def <<(x)
    if r = root
      @root = r.insert(x)
    else
      @root = Node.new(x)
    end
  end

  def erace(x)
    if r = root
      @root = r.erace(x)
    else
      puts "nothing to delete"
    end
  end

  def debug
    if r = root
      r.debug(0)
    end
  end
end

a = Treap.new
10.times do |i|
  a << i
end
a.erace(0)
a.erace(3)
a.erace(8)
a.debug
