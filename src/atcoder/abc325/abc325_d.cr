require "crystal/priority_queue"

class Want
  getter n : Int64
  getter a : Array(Tuple(Int64,Int64))

  def initialize(@n, td)
    @a = td.map do |t, d|
      {t, t+d}
    end.sort.reverse
  end

  def solve
    ans = 0_i64
    cur = 1_i64

    pq = PQ(Int64).lesser

    while a.size > 0 || pq.size > 0
      while a.size > 0 && a[-1][0] <= cur
        pq << a.pop[1]
      end

      while pq.size > 0 && pq[0] < cur
        pq.pop
      end

      if pq.size > 0
        pq.pop
        ans += 1
        cur += 1
      elsif a.size > 0
        cur = a[-1][0]
      end
    end

    return ans
  end
end

n = gets.to_s.to_i64
td = Array.new(n) do
  t, d = gets.to_s.split.map(&.to_i64)
  { t, t + d }
end

pp Want.new(n, td).solve
