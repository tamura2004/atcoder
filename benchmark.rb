require "benchmark/ips"
require "prime"

S = Array.new(100000){rand < 0.5 ? "L" : "R"}.join

Benchmark.ips do |x|
  x.report("a") {
    count = 0
    ans = Array.new(100000)
    S.chars.each_with_index do |a,i|
      if a == "R"
        ans[i] = count
        count = 0
      else
        count += 1
      end
    end
  }
  x.report("b") {
    S.size.times do |i|
      count = 0
      ans = Array.new(100000)
      if S[i] == "R"
        ans[i] = count
        count = 0
      else
        count += 1
      end
    end
  }
  x.compare!
end
