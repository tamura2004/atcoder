N = 200000
K = 10**18
open("src/input.txt", "w") do |f|
    f.puts [N,K].join(" ")
    f.puts Array.new(N){ rand(N) + 1 }.join(" ")
end
