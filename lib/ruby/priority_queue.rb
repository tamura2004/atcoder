class PriorityQueue
  attr_accessor :a, :op

  def initialize(&op)
    @a = []
    @op = op || ->(a, b) { a < b }
  end

  def self.lesser
    new
  end

  def self.greater
    new { |a, b| a > b }
  end

  def <<(v)
    a << v
    i = a.size - 1

    while i > 0
      pa = parent(i)
      break if op.call(a[pa], a[i])
      a[pa], a[i] = a[i], a[pa]
      i = pa
    end
  end

  def pop
    ans = a[0]
    tail = a.pop
    return ans if a.empty?

    a[0] = tail
    i = 0
    left, right = children(i)

    while left < a.size
      child = right < a.size && op.call(a[right], a[left]) ? right : left
      break if op.call(a[i], a[child])

      a[i], a[child] = a[child], a[i]
      i = child
      left, right = children(i)
    end

    ans
  end

  def parent(i)
    (i - 1) / 2
  end

  def children(i)
    [i * 2 + 1, i * 2 + 2]
  end

  def size
    a.size
  end
end
