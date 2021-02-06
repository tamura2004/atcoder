N = 400
M = 100000
open("sample.txt", "w") do |f|
  f.puts [N, M].join(" ")
  1.upto(399) do |i|
    (i + 1).upto(400) do |j|
      next if i == 350 && j == 400
      next if i == 300 && j == 350
      next if i == 300 && j == 400
      f.puts [i, j].join(" ")
    end
  end
  20203.times do
    f.puts("300 400")
  end
end
