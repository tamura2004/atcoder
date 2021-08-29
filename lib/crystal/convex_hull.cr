require "crystal/complex"

alias Dot = Complex(Int64)

# 凸包
def convex_hull(dots : Array(Dot))
  dots.sort!

  up = [] of Dot
  dots.each do |dot|
    while up.size >= 2 && (up[-1] - up[-2]).cross(up[-1] - dot) <= 0
      up.pop
    end
    up << dot
  end

  dn = [] of Dot
  dots.each do |dot|
    while dn.size >= 2 && (dn[-1] - dn[-2]).cross(dn[-1] - dot) >= 0
      dn.pop
    end
    dn << dot
  end

  up + dn[1..-2].reverse
end
