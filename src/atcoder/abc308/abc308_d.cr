require "crystal/graph"

h, w = gets.to_s.split.map(&.to_i64)
s = Array.new(h){gets.to_s}
g = (h * w).to_g

dic = {
  's' => 'n',
  'n' => 'u',
  'u' => 'k',
  'k' => 'e',
  'e' => 's',
}

h.times do |y|
  w.times do |x|
    i = y * w + x
    if to = dic[s[y][x]]?
      [{-1,0},{1,0},{0,1},{0,-1}].each do |dy, dx|
        ny = y + dy
        nx = x + dx
        next unless 0 <= ny < h && 0 <= nx < w
        next unless s[ny][nx] == to
        ii = ny * w + nx
        g.add i, ii, origin: 0, both: false
      end
    end
  end
end

seen = Array.new(h*w,false)
seen[0] = true
q = Deque.new([0])
while q.size > 0      
  v = q.shift
  quit :Yes if v == h * w - 1
  g.each(v) do |nv|
    next if seen[nv]
    seen[nv] = true
    q << nv
  end
end
puts :No

