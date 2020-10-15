N = 30

open("src/input.txt", "w") do |f|
  f.puts N
  N.times do
    f.puts "a" * N
  end
end
