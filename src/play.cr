require "crystal/complex"

def is_tokyakudaikei(v, nv, u, nu)
  return false if (nv - v).cross(nu - u) != 0
  t = v + nv - u - nu
  return false if t.zero?
  (nv - v).dot(t) == 0 && (nu - u).dot(t) == 0
end

n = gets.to_s.to_i
xyc = Array.new(n) do
  x, y, c = gets.to_s.split.map(&.to_i64)
  {C.new(x, y), c}
end

senbun = [] of {C, C, Int64, Float64}
xyc.each do |v, c|
  xyc.each do |nv, nc|
    next if v == nv
    senbun << {v, nv, c + nc, (nv - v).phase}
  end
end

senbun.sort_by! do |v, nv, c, phase|
  -c
end

ans = -1_i64
senbun.each_cons_pair do |(v, nv, cv, pv), (u, nu, cu, pu)|
  if is_tokyakudaikei(v, nv, u, nu)
    chmax ans, cv + cu
  end
end

pp ans
pp senbun.group_by(&.[] 3)