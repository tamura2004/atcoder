require "spec"
require "crystal/cumulative_sum_2d"

describe CumulativeSum2D do
  it "usage" do
    a = [
      [1,2,3,4,5],
      [2,3,4,5,6],
      [3,4,5,6,7],
      [4,5,6,7,8],
    ]
    cs = CS2D.new(a)
    # cs = a.to_cs_2d
    # 3,4,5
    # 4,5,6
    cs[1..2,1..3].should eq 27
  end

  it "solve arc025b case 1" do
    h = 3
    w = 4
    a = [
      [4, 6, 2, 5],
      [3, 5, 6, 7],
      [2, 5, 5, 6],
    ]
    ARC025B.new(h,w,a).solve.should eq 6
  end
end

macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

class ARC025B
  getter h : Int32
  getter w : Int32
  getter c : Array(Array(Int32))

  def initialize(@h, @w, @c)
  end

  def solve
    a = Array.new(h) do |i|
      Array.new(w) do |j|
        (i + j).even? ? c[i][j] : 0
      end
    end

    b = Array.new(h) do |i|
      Array.new(w) do |j|
        (i + j).odd? ? c[i][j] : 0
      end
    end

    white = CumulativeSum2D(Int32).new(a)
    black = CumulativeSum2D(Int32).new(b)

    ans = 0_i64
    h.times do |y1|
      w.times do |x1|
        (y1 + 1).upto(h) do |y2|
          (x1 + 1).upto(w) do |x2|
            if white.sum(y1, x1, y2, x2) == black.sum(y1, x1, y2, x2)
              chmax ans, (y2 - y1) * (x2 - x1)
            end
          end
        end
      end
    end
    return ans
  end
end
