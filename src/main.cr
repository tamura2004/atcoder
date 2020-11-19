class PriorityQueue(T)
  getter f : T, T -> Bool
  getter sum : T
  getter a : Deque(T)

  forward_missing_to a

  def initialize(&block : T, T -> Bool)
    @f = block
    @a = Deque(T).new
    @sum = T.zero
  end
  
  def initialize
    @f = ->(a : T, b : T) { a < b }
    @a = Deque(T).new
    @sum = T.zero
  end

  def <<(v : T)
    @sum += v
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
    @sum -= ret
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

class Median(T)
  getter lo : PriorityQueue(T)
  getter hi : PriorityQueue(T)

  def initialize
    @lo = PriorityQueue(T).new { |a, b| a < b }
    @hi = PriorityQueue(T).new { |a, b| a > b }
  end

  def <<(x)
    case
    when lo.size.zero?
      lo << x
    when hi.size.zero?
      if x < lo[0]
        hi << lo.pop
        lo << x
      else
        hi << x
      end
    when lo.size == hi.size
      if x <= hi[0]
        lo << x
      else
        lo << hi.pop
        hi << x
      end
    when lo.size > hi.size
      if lo[0] <= x
        hi << x
      else
        hi << lo.pop
        lo << x
      end
    end
  end

  def val
    lo[0]
  end
end

m = Median(Int64).new
h = 0_i64

n = gets.to_s.to_i
n.times do
  case line = gets.to_s
  when /^1/
    c, a, b = line.split.map { |v| v.to_i64 }
    m << a
    h += b
  when /^2/
    i = m.val
    ans = 0_i64
    ans += i * (m.lo.size) - m.lo.sum
    ans += m.hi.sum - i * (m.hi.size)
    puts "#{i} #{ans + h}"
  end
end
