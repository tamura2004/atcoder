# 素抜け君の位置と荷物の位置の数字４つを状態としてもつ
require "crystal/grid"

class Problem
  getter g : Grid
  getter sz : C
  getter az : C
  getter gz : C
  delegate "index", "outside?", "wall?", to: g

  def initialize(@g)
    @sz = index('s')
    @az = index('a')
    @gz = index('g')
  end

  def self.read
    h, w = gets.to_s.split.map(&.to_i)
    g = Grid.new(h, w)
    g.read
    new(g)
  end

  def solve
    init = {sz, az, 0_i64}
    q = Deque.new([init])
    seen = Set(Tuple(C, C)).new
    seen << {sz, az}

    while q.size > 0
      sz, az, cnt = q.shift
      quit cnt if az == gz

      g.each_dir do |dz|
        nsz = sz + dz
        next if outside?(nsz)
        next if wall?(nsz)

        naz = nsz == az ? az + dz : az
        next if outside?(naz)
        next if wall?(naz)

        nstate = {nsz, naz}
        next if nstate.in?(seen)

        seen << nstate
        q << {nsz, naz, cnt + 1}
      end
    end
    quit -1
  end
end

Problem.read.solve
