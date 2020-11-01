N = 10000

open("src/input.txt", "w") do |f|
  f.puts N
  cnt = [0]
  1.upto(N / 2) do |i|
    cnt << i
    cnt << i
  end
  f.puts cnt.join(" ")
end
