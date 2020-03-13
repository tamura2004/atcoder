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
 
class AgeRank
  include Comparable
  attr_reader :age, :rank
  def initialize(age,rank); @age = age; @rank = rank; end
  def <=>(other)
    age - other.age
  end
end
 
q = PriorityQueue.new
n,k = gets.split.map &:to_i
x = gets.split.map &:to_i
n.times do |i|
  q << AgeRank.new(x[i], i + 1)
  q.pop if q.size > k
  puts q.first.rank if q.size == k
end