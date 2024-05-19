x, y, r, n = gets.to_s.split.map(&.to_i64)

g = Array.new(n*2 + 1) { Array.new(n*2 + 1, '.') }
(-n..n).each do |i|
  (-n..n).each do |j|
    if (i - x)**2 + (j - y)**2 <= r**2
      g[i+n][j+n] = '#'
    end
  end
end

puts g.map(&.join(" ")).join("\n")
