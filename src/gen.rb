N = 100000

open("src/input.txt", "w") do |f|
  f.puts N
  f.puts Array.new(N){ rand 1..1000000000 }.join(" ")
end
