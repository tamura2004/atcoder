N = 2000000

open("src/input.txt", "w") do |f|
  f.puts N
  f.puts Array.new(N){ rand(N) }.join(" ")
end
