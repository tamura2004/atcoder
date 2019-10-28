require "benchmark/ips"
N = 1000000
Benchmark.ips do |x|
    x.report("bsearch") {
        m = (1..N).bsearch do |n|
            n > N/2
        end
    }

    x.report("liner") {
        m = (1..N).find do |n|
            n > N/2
        end
    }
    x.compare!
end

