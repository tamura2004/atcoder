open("src/input.txt", "w") do |f|
    f.puts Array.new(100000){ (?a..?z).to_a.sample }.join
    f.puts 200000
    200000.times do
        if rand < 0.5
            f.puts 1
        else
            f.puts [2, rand(2)+1, (?a..?z).to_a.sample].join(" ")
        end
    end
end
