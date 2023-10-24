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

class Got
  getter n : Int64
  getter a : Hash(Int64,Array(Tuple(Int64,Int64)))

  def initialize(@n, td)
    @a = td.map do |t, d|
      {t, t+d}
    end.group_by(&.[0])
    a[Int64::MAX] = [] of Tuple(Int64,Int64)
  end

  def solve
    ans = 0_i64
    cur = 1_i64

    pq = PQ(Tuple(Int64,Int64)).lesser

    a.keys.sort.each do |key|
      arr = a[key]
      while pq.size > 0 && cur < key
        hi, lo = pq.pop
        if cur <= hi
          cur += 1
          ans += 1
        end
      end
      cur = key

      arr.each do |lo, hi|
        pq << {hi, lo}
      end
    end

    return ans
  end
end

n = gets.to_s.to_i64
td = Array.new(n) do
  Tuple(Int64,Int64).from gets.to_s.split.map(&.to_i64)
end

# pp! Want.new(n, td).solve
pp Got.new(n, td).solve

# 100.times do
#   n = 100
#   td = (0...n).map do
#     t = rand(1_i64..10_i64)
#     d = rand(1_i64..10_i64)
#     { t, d }
#   end

#   want = Want.new(n, td).solve
#   got = Got.new(n, td).solve
#   if want != got
#     pp! [want, got, n, td]
#   end
# end
