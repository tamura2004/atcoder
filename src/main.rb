require "numo/narray"

class Animal
  attr_accessor *(?a..?z).to_a.map(&:to_sym)

  def initialize(n)
    @n = n
    @d = Array.new(3) { [nil] * n }
  end

  def [](i); d[i]; end

  def dot(y, x, v)
    return false if d[y][x] && d[y][x] != v
    d[y][x] = v
    true
  end

  def line(y, x, v)
    3.times do |i|
      return false unless dot(i, (x - y + i) % n, v)
    end
    true
  end
end

class Problem
  attr_accessor *(?a..?z).to_a.map(&:to_sym)

  def initialize
    @n = gets.to_s.to_i
    @s = gets.chomp.tr("xo", "10").chars.map(&:to_i)
  end

  def each_animals
    [0, 1].repeated_permutation(3) do |i, j, k|
      next if s[0] != [i, j, k].inject(:^)
      a = Animal.new(n)
      a.line(0, 0, i) or next
      a.line(1, 0, j) or next
      a.line(2, 0, k) or next
      yield a
    end
  end

  def valid?(a)
    1.upto(n - 1).all? do |x|
      v = a[1][x] ^ a[2][x] ^ s[x]
      a.line(0, x, v)
    end
  end

  def solve
    each_animals do |a|
      valid?(a) and return a[1]
    end
    return -1
  end

  def show(ans)
    puts ans == -1 ? -1 : ans.join.tr("10", "WS")
  end
end

Problem.new.instance_eval do
  show(solve)
end
