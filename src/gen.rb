N = 30

open("src/input.txt", "w") do |f|
  f.puts N
  x = 2
  a = []
  N.times do
    a << x
    x = x * 2 - 1
  end
  f.puts a.reverse.join(" ")
end
