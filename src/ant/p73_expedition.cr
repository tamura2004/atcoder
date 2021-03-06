class PriorityQueue(T)
  getter f : T, T -> Bool
  # getter sum : T
  getter a : Deque(T)

  forward_missing_to a

  def initialize(&block : T, T -> Bool)
    @f = block
    @a = Deque(T).new
    # @sum = T.zero
  end

  def initialize
    @f = ->(a : T, b : T) { a < b }
    @a = Deque(T).new
    # @sum = T.zero
  end

  def <<(v : T)
    # @sum += v
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
    # @sum -= ret
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
    (i - 1) // 2
  end
end

Z = 0_i64

n,l,p = gets.to_s.split.map { |v| v.to_i64 }
a = gets.to_s.split.map { |v| v.to_i64 }
b = gets.to_s.split.map { |v| v.to_i64 }
a = [Z] + a + [l]
b = [Z] + b + [Z]
q = PriorityQueue(Int64).new

ans = Z
(n+1).times.each_cons(2) do |(i,j)|
  p -= a[j] - a[i]
  while p < 0 && !q.empty?
    p += q.pop
    ans += 1
  end
  if p < 0
    puts -1
    exit
  end
  q << b[j]
end

puts ans