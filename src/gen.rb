W = %w(M A R C H)
open("src/input.txt", "w") do |f|
    f.puts "200000"
    200000.times do |i|
        f.puts i
    end
end
