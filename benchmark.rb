require "benchmark/ips"

N = 2000
L = Array.new(N){rand(1000)+1}

def a
    count = 0
    for i in 0...(N-2)
        for j in (i+1)...(N-1)
            lb = j
            rb = N
            k = L[i] + L[j]
            while rb - lb > 1
                mb = (lb+rb)/2
                L[mb] < k ? lb = mb : rb = mb
            end
            count += lb - j
        end
    end
    count
end

def b
    count = 0
    for i in 0...(N-2)
        for j in (i+1)...(N-1)
            lb = j
            rb = N
            while rb - lb > 1
                mb = (lb+rb)/2
                L[mb] < L[i] + L[j] ? lb = mb : rb = mb
            end
            count += lb - j
        end
    end
    count
end

Benchmark.ips do |x|
    x.report("a") {
        a
    }
    x.report("b") {
        b
    }
    x.compare!
end
