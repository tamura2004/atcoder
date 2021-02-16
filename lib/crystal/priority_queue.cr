class PriorityQueue(T)
  getter f : T, T -> Bool
  getter a : Deque(T)

  forward_missing_to a

  def initialize(&block : T, T -> Bool)
    @f = block
    @a = Deque(T).new
  end

  def initialize
    @f = ->(a : T, b : T) { a < b }
    @a = Deque(T).new
  end

  def <<(v : T)
    @a << v
    fixup(a.size - 1)
  end

  def pop : T
    ret = a[0]
    last = a.pop
    if a.size > 0
      a[0] = last
      fixdown
    end
    ret
  end

  def fixup(i : Int32)
    j = up(i)
    while i > 0 && comp j, i
      a.swap i, j
      i, j = j, up(j)
    end
  end

  def fixdown
    i = 0
    while lo(i) < a.size
      if hi(i) < a.size && comp lo(i), hi(i)
        j = hi(i)
      else
        j = lo(i)
      end
      break if comp j, i
      a.swap i, j
      i = j
    end
  end

  def comp(i, j)
    f.call a[i], a[j]
  end

  def lo(i)
    i * 2 + 1
  end

  def hi(i)
    i * 2 + 2
  end

  def up(i)
    (i - 1) >> 1
  end
end