n = gets.to_s.to_i64
a = Array.new(n) { gets.to_s }

ans = n.times.all? do |y|
  n.times.all? do |x|
    case {a[y][x], a[x][y]}
    when {'W', 'L'} then true
    when {'L', 'W'} then true
    when {'D', 'D'} then true
    when {'-', '-'} then true
    else                 false
    end
  end
end

puts ans ? "correct" : "incorrect" 