require "crystal/problem"
require "crystal/bsearch"

# 最小値の最大化
class Main < Problem
  getter n : Int32
  getter m : Int32
  getter a : Array(Int64)

  def initialize(@n, @m, @a)
  end

  def self.read(io : IO)
    n = io.gets.to_s.to_i
    m = io.gets.to_s.to_i
    a = io.gets.to_s.split.map(&.to_i64).sort
    new(n, m, a)
  end

  def solve
    bs = BSearch(Int64).new do |mid|
      c(mid)
    end

    bs.max_of(0_i64, Int64::MAX)
  end

  # 距離midを実現できるか
  def c(mid)
    cnt = [] of Int64
    a.each do |v|
      if cnt.empty? || v - cnt[-1] >= mid
        cnt << v
      end
    end
    cnt.size >= m
  end

  def run
    pp! self
    puts solve
  end
end

Main.read("5\n3\n1 2 8 4 9").run