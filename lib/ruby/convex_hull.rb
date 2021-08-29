require "complex"

def cross(a, b)
  (a.conj * b).imag
end

def convex_hull(dots)
  dots.sort_by! do |a|
    [a.real, a.imag]
  end

  up = []
  dots.each do |dot|
    while up.size >= 2 && cross(up[-1] - up[-2], up[-1] - dot) <= 0
      up.pop
    end
    up << dot
  end

  dn = []
  dots.each do |dot|
    while dn.size >= 2 && cross(dn[-1] - dn[-2], dn[-1] - dot) >= 0
      dn.pop
    end
    dn << dot
  end

  up + dn[1..-2].reverse
end
