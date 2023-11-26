n = gets.to_s.to_i64
s = Array.new(n){gets.to_s}

tate = Array.new(n, 0_i64)
yoko = Array.new(n, 0_i64)

n.times do |y|
  n.times do |x|
    if s[y][x] == 'o'
      tate[y] += 1
      yoko[x] += 1
    end
  end
end

ans = 0_i64

n.times do |y|
  n.times do |x|
    if s[y][x] == 'o'
      ans += (tate[y] - 1) * (yoko[x] - 1)
    end
  end
end

pp ans