require "crystal/geography"

n = gets.to_s.to_i
xy = Array.new(n) do
  x,y = gets.to_s.split.map(&.to_i64)
  Point.new(x,y)
end

xy.each_combination(3) do |(a,b,c)|
  cnt = [] of Point
  rr = [] of Float64
  [a,b,c].each_permutation(3) do |(x,y,z)|
    l1 = Line.new(x,y)
    l2 = Line.new(z,y)

    o = l1.virtical_bisctor.crosspoint(l2.virtical_bisctor)
    cnt << o
    
    [x,y,z].each do |w|
      rr << (w - o).abs
    end
  end

  if (cnt.map(&.imag).max - cnt.map(&.imag).min).abs > 1
    pp! [a,b,c]
    pp! cnt
  end

  if (cnt.map(&.real).max - cnt.map(&.real).min).abs > 1
    pp! [a,b,c]
    pp! cnt
  end
  
  if (rr.min - rr.max).abs > 1
    pp! [a,b,c]
    pp! cnt
    pp! rr
  end

end
