require "benchmark"
require "set"

h = Hash.new(false)
s = Set.new

Benchmark.bm 10 do |r|
    r.report "hash" do
        3000.times do |i|
            3000.times do |j|
                key = i * 10000 + j
                if h[key]
                    h[key] = true
                end
            end
        end
    end
    r.report "set" do
        3000.times do |i|
            3000.times do |j|
                key = i * 10000 + j
                unless s.include? key
                    s << key
                end
            end
        end
    end
end


