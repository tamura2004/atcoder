open("src/input.txt", "w") do |f|
    f.puts "100 10000"
    100.times do |i|
        f.puts rand(100)
        f.puts rand(100)
    end
end
