require "crystal/complex"

s = Array.new(9) { gets.to_s }
I = 1.i

def nex(a,b)
  c = b + (b - a) * I
  d = c + (c - b) * I
  {c,d}
end

ans = 0_i64

# ２点で全探索
9.times do |y|
  9.times do |x|
    next if s[y][x] != '#'
    a = y.i + x
    
    9.times do |ny|
      9.times do |nx|
        next if s[ny][nx] != '#'

        b = ny.i + nx
        next if a == b

        c, d = nex(a,b)

        next unless 0 <= c.y < 9
        next unless 0 <= c.x < 9
        next unless 0 <= d.y < 9
        next unless 0 <= d.x < 9

        next if s[c.y][c.x] != '#'
        next if s[d.y][d.x] != '#'

        ans += 1
      end
    end
  end
end

pp ans // 4


        