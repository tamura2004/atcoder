require "profile"

N = 64
M = N / 2

open("src/input.txt", "w") do |f|
  f.puts [N,N].join(" ")
  f.puts [1,1].join(" ")
  f.puts [N,N].join(" ")

  M.times do
    f.puts ".#" * M
    f.puts "#." * M
  end
end
