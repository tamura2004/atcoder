a,b = gets.to_s.split.map { |v| v.to_i }
seen = Array.new(100, -1)

que = [a]
seen[a] = 0
while que.size > 0
  v = que.shift
  d = seen[v]
  if v == b
    puts d
    exit
  end

  [-10,10,-5,5,-1,1].each do |dv|
    nv = v + dv
    next if nv < -5 || 40 < nv
    next if seen[nv] != -1
    seen[nv] = d + 1
    que << nv
  end
end
