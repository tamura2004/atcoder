open("src/input.txt", "w") do |f|
    f.puts "30000"
    30000.times do
        f.print rand(9)+1
    end
    f.puts
end
