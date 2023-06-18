require "crystal/matrix"
require "crystal/modint9"

class ProblemSmall
  getter n : Int64
  getter m : Int64
  getter bs : Array(String)
  getter ans : Array(Int32)

  def initialize(@n, @m, @bs)
    @ans = Array.new(1 << n, 0)
  end

  def solve
    (1 << n).times do |i|
      sa = sprintf("%0#{n}b", i)
      ans[i] = bs.none?(&.in?(sa)).to_unsafe
    end
    ans
  end
end

LEN  = 5_i64
MASK = (1 << (LEN - 1)) - 1

class ProblemLarge
  getter n : Int64
  getter m : Int64
  getter bs : Array(String)
  getter banned : Array(Bool)

  def initialize(@n, @m, @bs)
    @banned = Array.new(1 << LEN.succ, false)
    bs.each do |s|
      ['0', '1'].repeated_permutations(LEN.succ - s.size).each do |t|
        i = (t.join + s).to_i64(2)
        banned[i] = true
      end
    end
  end

  def solve
    mt = Matrix(ModInt).zero(1 << LEN)
    (1 << LEN).times do |x|
      2.times do |i|
        next if banned[(x << 1) + i]
        y = ((x & MASK) << 1) + i
        mt[y, x] = 1.to_m
      end
    end

    # pp! banned
    v = ProblemSmall.new(LEN, m, bs).solve.map(&.to_m)
    # pp! mt
    # pp! mt * mt
    # pp! mt * mt * mt
    # pp! mt ** 1
    # pp! v
    (mt ** (n - LEN)) * v
  end
end

n, m = gets.to_s.split.map(&.to_i64)
bs = Array.new(m) { gets.to_s.tr("ab", "01") }

if n < 10
  ans = ProblemSmall.new(n, m, bs).solve
  pp ans.sum
else
  ans = ProblemLarge.new(n, m, bs).solve
  pp ans.sum
end