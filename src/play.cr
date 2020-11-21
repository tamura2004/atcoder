class Node
  getter ch : Array(Pointer(Node))
  getter v : Int32
  getter pri : Int32
  getter cnt : Int32
  getter sum : Int32

  def initialize(@v)
    @ch = [Pointer(Node).null] * 2
    @cnt = 1
    @sum = v
    @pri = rand(Int32::MAX)
  end

  def insert(x : Int32)
    i = x < v ? 0 : 1
    if @ch[i].null?
      @ch[i] = Pointer(Node).malloc(1, Node.new(x))
    else
      @ch[i].value.insert(x)
    end
  end

  def update
    @cnt = ch.map(&.cnt).sum + 1
    @sum = ch.map(&.sum).sum + v
    self
  end

  def rotate(b)
    s = ch[1-b]
    ch[1-b] = s.value.ch[b]
    s.value.ch[b] = 
  end
end

struct Pointer(T)
  def cnt
    null? ? 0 : value.cnt
  end

  def sum
    null? ? 0 : value.sum
  end

  def rotate(b)
    s = value.ch[1-b]
    value.ch[1-b] = s.value.ch[b]
    s.value.ch[b] = self
    value.update
    s.value.update
    return s
  end
end

root = Node.new(50)
pp! root.ch[0]
root.insert(30)
root.insert(20)
root.insert(40)
root.insert(70)
root.insert(60)
root.insert(80)

pp! root.v
pp! root.ch[0].value
