require "crystal/indexable"
require "crystal/bitset"


class Problem
  getter n : Int64
  getter m : Int64
  getter a : Array(Array(Int64))

  def initialize(@n, @m, @a)
  end

  def self.read
    n, m = gets.to_s.split.map(&.to_i64)
    a = Array.new(n) { gets.to_s.split.map(&.to_i64) }
    new(n, m, a)
  end

  def solve
    tate = Array.new(n) { n.to_bitset }
    ix = (0...n).to_a
    
    m.times do |j|
      ix.group_by { |i| a[i][j] }.values.each do |arr|
        wk = n.to_bitset.set_at(arr)
        arr.each do |k|
          tate[k].xor! wk
        end
      end
    end
    
    ans = tate.sum(&.popcount.to_i64)
    ans -= n if m.odd?
    ans //= 2
    ans
  end
end

class Bad
  getter n : Int64
  getter m : Int64
  getter a : Array(Array(Int64))

  def initialize(@n, @m, @a)
  end

  def solve
    tate = Array.new(n) { n.to_bitset }
    ix = (0...n).to_a
    
    m.times do |j|
      ix.group_by { |i| a[i][j] }.values.each do |arr|
        wk = n.to_bitset
        arr.each do |k|
          wk.set(k)
        end
        arr.each do |k|
          tate[k].xor! wk
        end
      end
    end
    
    ans = tate.sum(&.popcount)
    ans -= n if m.odd?
    ans //= 2
    ans
  end
end

# n, m = gets.to_s.split.map(&.to_i64)
# a = Array.new(n) { gets.to_s.split.map(&.to_i64) }

10.times do
  n = 210_i64
  m = 229_i64
  a = Array.new(n) { Array.new(m) { rand(1000_i64) }}

  got = Bad.new(n, m, a).solve
  want = Problem.new(n, m, a).solve

  if got != want
    pp! [n, m, a, got, want]
  end
end

pp! 1 << 60