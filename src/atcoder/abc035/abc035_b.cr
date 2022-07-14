require "crystal/complex"

dir = {
  'L' => -1.x,
  'R' => 1.x,
  'U' => 1.y,
  'D' => -1.y,
}

pos = 0.x + 0.y
cnt = 0

s = gets.to_s.chars
s.each do |d|
  if d == '?'
    cnt += 1
  else
    pos += dir[d]
  end
end

t = gets.to_s.to_i64
dist = pos.manhattan

if t == 1
  pp dist + cnt
elsif cnt < dist
  pp dist - cnt
elsif (cnt - dist) % 2 == 0
  pp 0
else
  pp 1
end
