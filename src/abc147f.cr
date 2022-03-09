# n,x,d = gets.to_s.split.map(&.to_i64)

1000.times do
  n = rand(1i64..12i64)
  x = rand(1i64..100i64)
  d = rand(1i64..100i64)
  got = Got.new(n, x, d).solve
  want = Want.new(n, x, d).solve
  if got != want
    pp! [n, x, d]
    pp! [got, want]
  end
end

class Want
  getter n : Int64
  getter x : Int64
  getter d : Int64

  def initialize(@n, @x, @d)
  end

  def solve
    ans = Set(Int64).new
    (1 << n).times do |s|
      cnt = 0_i64
      n.times do |i|
        if s.bit(i) == 1
          cnt += x + d * i
        end
      end
      ans << cnt
    end
    ans.size
  end
end

class Got
  getter n : Int64
  getter x : Int64
  getter d : Int64
  getter cnt : Array(Array(Tuple(Int64, Int64)))

  def initialize(@n, @x, @d)
    @cnt = Array.new(d.abs) do
      [] of Tuple(Int64, Int64)
    end
  end

  def rec
    (0..n).each do |i|
      k = x * i
      j = (x * i) % d
      lo = (0i64...i).sum
      hi = (n - i...n).sum
      cnt[j] << {lo + k // d, hi + k // d}
    end
  end

  def solve
    rec
    ans = 0_i64
    cnt.each do |a|
      marge(a).each do |r|
        ans += r[1] - r[0] + 1
      end
    end
    ans
  end

  def marge(a)
    a.sort_by!(&.[0])
    ans = [] of Tuple(Int64, Int64)
    a.each do |l, r|
      if ans.empty? || ans[-1][1] < l
        ans << {l, r}
      else
        pl, pr = ans.pop
        ans << {Math.min(pl, l), Math.max(pr, r)}
      end
    end
    ans
  end
end
