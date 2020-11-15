N = 100
a = [0, 0] + [0] * (N - 2)

open("src/input.txt", "w") do |f|
  f.puts N
  N.times do |i|
    f.puts Array.new(N) { rand < 0.01 ? 1 : 0 }.join
  end
end
