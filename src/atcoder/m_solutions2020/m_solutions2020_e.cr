# 全探索

class Problem
  TATE = 0
  YOKO = 1
  NONE = 2

  enum Kind
    Road
    Town
  end

  getter n : Int32
  getter towns : Array(Tuple(Int64, Int64, Int64))
  getter dist : Array(Array(Array(Int64)))
  getter ans : Array(Int64)

  def initialize(@n, @towns)
    @dist = make_array(Int64::MAX, 2, 1 << n, n)
    2.times { |dir| pre_calc(dir) }
    @ans = Array.new(n + 1, Int64::MAX)
  end

  def self.read
    n = gets.to_s.to_i
    towns = Array.new(n) do
      x, y, po = gets.to_s.split.map(&.to_i64)
      {x, y, po}
    end
    new(n, towns)
  end

  def pre_calc(dir)
    (1 << n).times do |s|
      ev = [{0_i64, Kind::Road, -1}]
      n.times do |i|
        ev << {towns[i][dir], Kind::Town, i}
        next if s.bit(i).zero?
        ev << {towns[i][dir], Kind::Road, -1}
      end
      ev.sort!

      2.times do
        pre = Int64::MIN
        ev.each do |d, kind, i|
          if kind.road?
            pre = d
          elsif pre != Int64::MIN
            chmin dist[dir][s][i], (d - pre).abs
          end
        end
        ev.reverse!
      end
    end
  end

  def solve
    [TATE, YOKO, NONE].each_repeated_permutation(n) do |pa|
      cnt = n
      tate_mask = 0
      yoko_mask = 0
      n.times do |i|
        case pa[i]
        when TATE then tate_mask |= (1 << i)
        when YOKO then yoko_mask |= (1 << i)
        else
          cnt -= 1
        end
      end

      min_dist = dist[TATE][tate_mask].zip(dist[YOKO][yoko_mask]).map { |i, j| Math.min(i, j) }
      tot = n.times.sum do |i|
        towns[i][2] * min_dist[i]
      end
      chmin ans[cnt], tot
    end
    ans
  end
end

puts Problem.read.solve.join("\n")
