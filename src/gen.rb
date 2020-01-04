W = %w(M A R C H)
open("src/input.txt", "w") do |f|
    f.puts "100000"
    100000.times do |i|
        f.puts i+1
    end
end
