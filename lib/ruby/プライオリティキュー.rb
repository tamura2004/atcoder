# ruby 2.7 + numo/ndarray
require "numo/narray"

class PriorityQueue
  attr_accessor :heap, :size
  def initialize(n)
    @heap = Numo::Int64.zeros(n)
    @size = 0
  end

  def <<(x)
    i = size
    self.size += 1
    while i > 0
      j = (i - 1) / 2
      break if heap[j] >= x # <
      heap[i] = heap[j]
      i = j
    end
    heap[i] = x
  end

  def pop
    ret = heap[0]
    self.size -= 1
    x = heap[size]
    i = 0
    while i * 2 + 1 < size
      a = i * 2 + 1
      b = i * 2 + 2
      a = b if b < size && heap[b] > heap[a] # <
      break if heap[a] <= x #<
      heap[i] = heap[a]
      i = a
    end
    heap[i] = x
    ret
  end
end

# ruby 2.3
class PriorityQueue < Array
  def <<(x)
    super(x)
    i = size - 1
    while i > 0
      j = parent(i)
      swap_if(i,j)
      i = j
    end
  end
 
  def push(x); self << x; end
 
  def pop
    x = super
    ret = self[0]
    return x if ret.nil?
    self[0] = x
    i = 0
    while parent?(i)
      j, k = children(i)
      j = k if self[k] && self[j] < self[k]
      swap_if(j,i)
      i = j
    end
    ret
  end
 
  private
 
  def swap(i, j); self[i], self[j] = self[j], self[i]; end
  def swap_if(i,j); swap(i,j) if self[i] > self[j]; end
  def parent(i); (i - 1) / 2; end
  def parent?(i); i * 2 + 1 < size; end
  def children(i); [i * 2 + 1, i * 2 + 2]; end
end
 
n,m = gets.split.map &:to_i
work = n.times.map{ gets.split.map(&:to_i) }.sort_by(&:first)

que = PriorityQueue.new
ans = 0
i = 0

1.upto(m) do |j|
  loop do
    break if !work[i] || work[i].first > j
    que << work[i].last
    i += 1
  end
  next if que.empty?
 
  v = que.pop
  ans += v
end
 
puts ans