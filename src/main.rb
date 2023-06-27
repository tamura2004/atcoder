n, m = gets.split.map(&:to_i)

# mod[i][j] := jがi個並んだ数字をmで割った余り
mod = Array.new(n + 1) { Array.new(11, 0) }
11.times do |j|
  (1..n).each do |i|
    mod[i][j] = (mod[i - 1][j] * 10 + j) % m
  end
end

(1..n).reverse_each do |i|
  (1..9).reverse_each do |j|
    if mod[i][j] == 0
      puts j.to_s * i
      exit
    end
  end
end
puts -1
