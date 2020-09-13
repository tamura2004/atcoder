W = 20
H = 20
P = 20

open("src/input.txt", "w") do |f|
  f.puts [W,H,P].join(" ")
  H.times do
    f.puts Array.new(W){ rand 0..100 }.join(" ")
  end
  P.times do
    f.puts [rand(0...H),rand(0...W)].join(" ")
  end
  f.puts "0 0 0"
end
