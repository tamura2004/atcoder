N = 1000
M = 200000000
open("src/input.txt", "w") do |f|
    f.puts [N,M].join(" ")
    N.times do
        f.puts Array.new(2){ rand(10**8) + 1 }.join(" ")
    end
end
