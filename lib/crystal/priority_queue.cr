class PriorityQueue(T) < Array(T)
  getter f : T, T -> Bool

  def initialize(&block : T, T -> Bool)
    super()
    @f = block
  end

  def initialize
    super()
    @f = ->(a : T, b : T) { a < b }
  end

  def push(v : T)
    super(v)
    fixup(size - 1)
  end

  def pop : T
    ret = self[0]
    last = super
    if size > 0
      self[0] = last
      fixdown
    end
    ret
  end

  def fixup(i : Int32)
    j = up(i)
    while i > 0 && comp j, i
      swap i, j
      i, j = j, up(j)
    end
  end

  def fixdown
    i = 0
    while lo(i) < size
      if hi(i) < size && comp lo(i), hi(i)
        j = hi(i)
      else
        j = lo(i)
      end
      break if comp j, i
      swap i, j
      i = j
    end
  end

  def comp(i, j)
    f.call self[i], self[j]
  end

  def lo(i)
    i * 2 + 1
  end

  def hi(i)
    i * 2 + 2
  end

  def up(i)
    (i - 1) // 2
  end
end
