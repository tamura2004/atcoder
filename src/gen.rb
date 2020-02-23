open("src/input.txt", "w") do |f|
    f.puts "100"
    f.puts 100.times.map{ rand(99)+1 }.join(" ")
end
