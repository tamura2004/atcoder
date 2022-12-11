class Node
  getter ord : Int32
  getter cnt : Int32
  getter ch : StaticArray(Node?, 2)

  def initialize(@ord)
    @cnt = 0
    @ch = StaticArray[nil.as(Node?), nil.as(Node?)]
  end

  def <<(a)
    @cnt += 1
    return if ord.zero?
    i = a.bit(ord - 1)
    ch[i] = nex = ch[i] || Node.new(ord - 1)
    nex << a
  end

  def inspect
    "(#{ch[0].inspect} #{cnt} #{ch[1].inspect})"
  end

  def dfs
    return 0 if ord.zero?
    off, on = ch
    case {off, on}
    when {Nil, Nil}  then 0
    when {Nil, Node} then on.dfs
    when {Node, Nil} then off.dfs
    when {Node, Node}
      (1 << (ord - 1)) + Math.min(off.dfs, on.dfs)
    else
      raise "error"
    end
  end
end

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
t = Node.new(30)
n.times do |i|
  t << a[i]
end
ans = t.dfs
pp ans
