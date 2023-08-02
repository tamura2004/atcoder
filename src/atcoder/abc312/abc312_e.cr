n = gets.to_s.to_i
dp = make_array(nil.as(Int32?), 100, 100, 100)

n.times do |i|
  x1, y1, z1, x2, y2, z2 = gets.to_s.split.map(&.to_i)
  (x1...x2).each do |x|
    (y1...y2).each do |y|
      (z1...z2).each do |z|
        dp[x][y][z] = i
      end
    end
  end
end

ans = Array.new(n) { Set(Int32).new }
100.times do |x|
  100.times do |y|
    100.times do |z|
      i = dp[x][y][z]
      next if i.nil?

      [{1, 0, 0}, {0, 1, 0}, {0, 0, 1}].each do |dx, dy, dz|
        nx = x + dx
        ny = y + dy
        nz = z + dz

        next if nx == 100
        next if ny == 100
        next if nz == 100

        j = dp[nx][ny][nz]
        next if j.nil?

        next if i == j

        ans[i] << j
        ans[j] << i
      end
    end
  end
end

puts ans.map(&.size).join("\n")
