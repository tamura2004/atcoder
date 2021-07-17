# 掃き出し法
require "big"

class Matrix
  getter n : Int32
  getter m : Int32
  getter a : Array(BigInt)

  def initialize(a)
    @a = a.map(&.to_big_i)
    @n = a.size
    @m = a.map(&.bit_length).max
  end

  def sweep
    row = 0
    col = 0

    while row < n && col < m
      if i = a.index(offset: row) { |v| v.bit(col) == 1 }
        a.swap row, i
        n.times do |j|
          a[j] ^= a[row] if j != row && a[j].bit(col) == 1
        end
        row += 1
      end
      col += 1
    end
  end

  def solve(s)
    n.times do |i|
      x = s.trailing_zeros_count
      y = (s ^ a[i].trailing_zeros_count)
      if y < x
        s ^= a[i]
      end
      pp! s
    end

    if s.zero?
      x = a.count(&.zero?)
      ans = 1_i64
      x.times do
        ans *= 2
        ans %= 998244353
      end
      pp ans
    else
      pp! a
      pp! s
      pp 0
    end
  end

  def show
    puts "-" * m
    n.times do |i|
      puts sprintf("%0#{m}b", a[i]).chars.reverse.join
    end
  end
end

n,m = gets.to_s.split.map(&.to_i64)
a = Array.new(n) do
  t = gets
  cnt = 0.to_big_i
  gets.to_s.split.map(&.to_i.- 1).each do |i|
    cnt |= 1.to_big_i << i
  end
  cnt
end
m = Matrix.new(a)
s = 0.to_big_i
gets.to_s.split.map(&.to_i).each_with_index do |v,i|
  s |= 1.to_big_i << i if v == 1
end

m.sweep
m.solve(s)



