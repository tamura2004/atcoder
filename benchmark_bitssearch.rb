require "benchmark"

N = 19
M = 100
A = (1..N).to_a

Benchmark.bm 10 do |r|
    r.report "library" do
        count = 0
        [true, false].repeated_permutation(N) do |flags|
            count += 1 if A.select.with_index{|a,i|flags[i]}.inject(:+) == M
        end
        puts count
    end
    r.report "bits" do
        count = 0
        (2**N).times do |bit|
            s = 0
            N.times do |i|
                s += A[i] if bit[i] == 1
            end
            count += 1 if s == M
        end
        puts count
    end
end
