def max(a,b); a > b ? a : b; end

class PQ
  attr_accessor :arr
  def initialize(arr)
    @arr = arr.sort!.reverse!
  end

  def at(i); @arr[i-1]; end
  def swap(i,j); @arr[i-1], @arr[j-1] = @arr[j-1], @arr[i-1]; end
  def size; @arr.size; end

  def half
    @arr[0] /= 2
    i = 1
    until i * 2 > size
      j,k = i*2,i*2+1
      if at(k).nil? || at(k) <= at(j)
        if at(i) <= at(j)
          swap(i,j)
          i = j
        else
          break
        end
      else
        if at(i) <= at(k)
          swap(i,k)
          i = k
        else
          break
        end
      end
    end
  end
end

pq = PQ.new([7,6,5,4,3,2,1])
20.times do
  pq.half
end
p pq.arr