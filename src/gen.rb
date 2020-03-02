open("src/input.txt", "w") do |f|
    f.puts "100000"
    f.puts ([*?a..?z] * 3000).join
end
