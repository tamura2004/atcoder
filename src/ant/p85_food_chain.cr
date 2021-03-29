require "crystal/problem"
require "crystal/union_find_tree"

class Main < Problem
  getter n : Int32
  getter k : Int32
  getter a : Array(Tuple(Int32, Int32, Int32))

  def initialize(@n, @k, @a)
  end

  def self.read(io : IO)
    n = io.gets.to_s.to_i
    k = io.gets.to_s.to_i
    a = Array.new(k) do
      cmd, x, y = io.gets.to_s.split.map(&.to_i.- 1)
      cmd += 1
      {cmd, x, y}
    end
    new(n, k, a)
  end

  def solve
    uf = UnionFindTree.new(n*3)
    a.each_with_index do |(cmd, x, y), i|
      if param_error?(x, y)
        puts "i = #{i + 1}, param error"
        next
      end

      tx = types(x)
      ty = types(y)

      case cmd
      when 1 # xとyは同じ種類
        if same_error?(tx, ty, uf)
          puts "i = #{i + 1}, same error"
        else
          3.times do |i|
            uf.unite tx[i], ty[i]
          end
        end
      when 2 # xはyを食べる
        if eat_error?(tx, ty, uf)
          puts "i = #{i + 1}, eat error"
        else
          3.times do |i|
            j = (i + 1) % 3
            uf.unite tx[i], ty[j]
          end
        end
      end
    end
  end

  def param_error?(x, y)
    return true if x < 0 || n <= x
    return true if y < 0 || n <= y
    return false
  end

  def same_error?(tx, ty, uf)
    3.times do |i|
      3.times do |j|
        return true if i != j && uf.same?(tx[i], ty[j])
      end
    end
    return false
  end

  def eat_error?(tx, ty, uf)
    3.times do |i|
      3.times do |j|
        return true if (i + 1) % 3 != j && uf.same?(tx[i], ty[j])
      end
    end
    return false
  end

  def types(x)
    {x, x + n, x + n * 2}
  end

  def run
    # pp! self
    puts solve
  end
end

Main.read(<<-EOS
100
7
1 101 1
2 1 2
2 2 3
2 3 3
1 1 3
2 3 1
1 5 5
EOS
).run
