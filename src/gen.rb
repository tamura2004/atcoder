N = 50
Q = 2500
open("src/input.txt", "w") do |f|
  f.puts N
  N.times do
    f.puts Array.new(N){ rand(100) }.join(" ")
  end
  f.puts Q
  Q.times do
    f.puts rand(2500)
  end
end
