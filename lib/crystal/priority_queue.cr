# プライオリティキュー
class PriorityQueue(T)
  getter f : T, T -> Bool
  getter a : Array(T)

  delegate size, to: a
  delegate empty?, to: a
  delegate "[]", to: a
  # forward_missing_to a

  def self.lesser
    new { |a,b| a > b }
  end

  def self.greater
    new { |a,b| a < b }
  end

  def initialize(&block : T, T -> Bool)
    @f = block
    @a = Array(T).new
  end

  def initialize
    @f = ->(a : T, b : T) { a < b }
    @a = Array(T).new
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

  @[AlwaysInline]
  def comp(i, j)
    f.call a[i], a[j]
  end
  
  @[AlwaysInline]
  def lo(i)
    i * 2 + 1
  end
  
  @[AlwaysInline]
  def hi(i)
    i * 2 + 2
  end
  
  @[AlwaysInline]
  def up(i)
    (i - 1) >> 1
  end
end

alias PQ = PriorityQueue

module Indexable(T)
  def to_pq_lesser
    q = PriorityQueue(T).lesser
    each do |v|
      q << v
    end
    q
  end

  def to_pq_greater
    q = PriorityQueue(T).greater
    each do |v|
      q << v
    end
    q
  end
end
