open("src/input.txt", "w") do |f|
    f.puts Array.new(1000){(?0..?9).to_a.sample}.join
end
