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

  def clear
    a.clear
  end
end

# M個の訴訟を開始順でソート
# 各島について先頭から処理
# PQは小さい順
# PQの先頭・右端が、現在の島だったら
#   取り除く橋の本数＋＋
#   PQを空に
# 訴訟の左端だったら、右端をPQに入れる

n,m  = gets.to_s.split.map { |v| v.to_i }
ab = Array.new(m){ gets.to_s.split.map { |v| v.to_i64 - 1 } }.sort
ab = Deque.new(ab)
pq = PriorityQueue(Int64).new { |a, b| a > b }

ans = 0_i64
n.times do |i|
  if pq.size > 0 && pq[0] == i
    ans += 1
    pq.clear
  end

  while ab.size > 0 && ab.try(&.first).try(&.first) == i
    pq << ab.shift[1]
  end
end

puts ans