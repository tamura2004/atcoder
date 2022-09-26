require "crystal/matrix"
require "crystal/modint9"

class RowBuilder
  getter n : Int64
  getter s : Int64
  getter row : Array(Int64)

  def initialize(@n, @s)
    @row = Array.new(1i64 << n, 0i64)
  end

  def solve
    dfs(s, 0i64, 0i64)
    row
  end

  def dfs(s, t, i)
    case
    when i == n
      row[t] += 1
    when s.bit(i) == 1
      dfs(s, t, i + 1)
    else
      dfs(s, t, i + 1)
      dfs(s, t | (1i64 << i), i + 1)
      if i < n - 1 && s.bit(i + 1) == 0
        dfs(s, t, i + 2)
      end
    end
  end
end

class Problem
  getter h : Int64
  getter w : Int64
  getter mt : Matrix(ModInt)

  def initialize(@h, @w)
    a = Array.new(1i64 << h) do |s|
      RowBuilder.new(h, s.to_i64).solve
    end
    @mt = Matrix(ModInt).new(a)
  end

  def self.read
    h, w = gets.to_s.split.map(&.to_i64)
    new(h, w)
  end

  def solve
    (mt ** w)[0, 0]
  end
end

pp Problem.read.solve
