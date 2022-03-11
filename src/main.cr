# n, m = gets.to_s.split.map(&.to_i64)
# a = gets.to_s.split.map(&.to_i64)

n = 2i64
m = 20i64
a = [2i64, 4i64]

want = Want.new(n, m, a).solve
got = Got.new(n, m, a).solve

if want != got
  pp! n
  pp! m
  pp! a
  pp! want
  pp! got
else
  print "."
end

class Want
  getter n : Int64
  getter m : Int64
  getter a : Array(Int64)

  def initialize(@n, @m, @a)
  end

  def solve
    (1..m).to_a.count do |x|
      a.all? do |v|
        x % (v // 2) == 0 && (x // (v // 2)).odd?
      end
    end
  end
end

class Got
  getter n : Int64
  getter m : Int64
  getter a : Array(Int64)

  def initialize(@n, @m, @a)
  end

  def solve
    b = a.map(&.// 2)

    x = 1_i64
    b.each do |y|
      x = x.lcm(y)
      return 0 if m < x
    end

    m // x - m // (x * 2)
  end
end
