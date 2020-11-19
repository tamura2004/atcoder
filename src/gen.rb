N = 100

open("src/input.txt", "w") do |f|
  f.puts N
  (N - 1).times do |i|
    f.puts "1 #{i} #{i}"
  end
  f.puts 2
end
