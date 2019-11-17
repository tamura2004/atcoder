require "benchmark/ips"
require "prime"

def a
    x = Prime.prime_division(123456789012)
end

Benchmark.ips do |x|
    x.report("a") {
        a
    }
    # x.report("b") {
    #     b
    # }
    # x.compare!
end
