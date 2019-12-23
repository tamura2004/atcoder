open("src/input.txt", "w") do |f|
    f.puts "100000 1 2"
    99999.times do |i|
        f.puts "#{i+1} #{i+2}"
    end
end
