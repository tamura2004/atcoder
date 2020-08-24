N = 300000

open("src/input.txt", "w") do |f|
  f.puts [N,N,N].join(" ")

  N.times do |i|
    f.puts [i,i].join(" ")
  end
end
