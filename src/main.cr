n = gets.to_s.to_i
a = Array.new(n) { gets.to_s.to_i }

class Q
  WHITE = 0
  BLACK = 1

  getter q : Array(Array(Int32))

  def initialize
    @q = Array.new(2) { [] of Int32}
  end

  def tail
    (q[WHITE][-1] < q[BLACK][-1]).to_unsafe
  end

  def add(stone, i)
    if q[stone].empty?
      q[stone] << i
      return
    end

    q[stone].pop if i.even? && tail == stone
    q[1-stone].pop if i.odd? && tail != stone
    q[stone].pop if i.odd? && tail != stone
    q[stone] << i
  end
end

q = Q.new
q.add(1,0)
q.add(1,1)
pp q