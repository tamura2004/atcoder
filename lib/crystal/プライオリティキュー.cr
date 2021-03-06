class PriorityQueue(T)
  def initialize(capacity : Int32)
    @elem = Array(T).new(capacity)
  end

  def initialize(list : Enumerable(T))
    @elem = list.to_a
    1.upto(size - 1) { |i| fixup(i) }
  end

  def size
    @elem.size
  end

  def add(v)
    @elem << v
    fixup(size - 1)
  end

  def top
    @elem[0]
  end

  def pop
    ret = @elem[0]
    last = @elem.pop
    if size > 0
      @elem[0] = last
      fixdown(0)
    end
    ret
  end

  def decrease_top(new_value : T)
    @elem[0] = new_value
    fixdown(0)
  end

  def to_s(io : IO)
    io << @elem
  end

  private def fixup(index : Int32)
    while index > 0
      parent = (index - 1) // 2
      break if @elem[parent] >= @elem[index]
      @elem[parent], @elem[index] = @elem[index], @elem[parent]
      index = parent
    end
  end

  private def fixdown(index : Int32)
    while true
      left = index * 2 + 1
      break if left >= size
      right = index * 2 + 2
      child = right >= size || @elem[left] > @elem[right] ? left : right
      if @elem[child] > @elem[index]
        @elem[child], @elem[index] = @elem[index], @elem[child]
        index = child
      else
        break
      end
    end
  end
end

class Problem
  @x : Int64
  @y : Int64
  @a : Int64
  @b : Int64
  @c : Int64
  @p : PriorityQueue(Int64)
  @q : PriorityQueue(Int64)
  @r : PriorityQueue(Int64)
  property :a, :b, :c, :x, :y, :p, :q, :r

  def initialize
    @x, @y,@a,@b,@c = gets.to_s.split.map(&.to_i64)
    @p = PriorityQueue.new(gets.to_s.split.map(&.to_i64))
    @q = PriorityQueue.new(gets.to_s.split.map(&.to_i64))
    @r = PriorityQueue.new(gets.to_s.split.map(&.to_i64))
  end

  def solve
  end

  def calc
  end
end

pr = Problem.new
pr.solve

pr.p.pop
pr.p.pop
pr.p.pop
pr.p.pop
pp pr.p.size
