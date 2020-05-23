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
      break if heap[j] >= x
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
      a = b if b < size && heap[b] > heap[a]
      break if heap[a] <= x
      heap[i] = heap[a]
      i = a
    end
    heap[i] = x
    ret
  end
end

n = gets.to_i
g = Array.new(n){ [] }
n.times do
  a,b = gets.split.map(&:to_i)
  a -= 1
  g[a] << b
end
que = PriorityQueue.new(n+1)
ans = 0
n.times do |i|
  g[i].each do |v|
    que << v
  end
  ans += que.pop
  puts ans
end

