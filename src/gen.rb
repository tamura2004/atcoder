W = %w(M A R C H)
open("src/input.txt", "w") do |f|
    f.puts "100"
    100.times do |i|
        f.puts rand(100)+1
    end
end
