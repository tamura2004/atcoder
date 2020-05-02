N = 3000
open("src/input.txt", "w") do |f|
    f.puts N
    
    N.times do |i|
        f.puts [rand(501)*10, rand(501)*10].join(" ")
    end
    #     x = 10 ** i
    #     if x % 2019 == 1
    #         f.puts [i, x, x % 2019].join(" ")
    #     end
    #     # f.puts [rand(501), rand(501)].join(" ")
    # end
end
