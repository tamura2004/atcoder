n = gets.to_s.to_i64
a = Array.new(n){ gets.to_s.chars.map(&.to_i) }

n.times do |i|
  a[i][i] = 1
end

n.times do |k|
  n.times do |i|
    n.times do |j|
      if a[i][k] & a[k][j] == 1
        a[i][j] = 1
      end
    end
  end
end

a = a.transpose

ans = n.times.sum do |i|
  1.0f64 / a[i].sum
end

pp ans