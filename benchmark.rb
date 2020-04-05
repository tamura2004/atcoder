require "benchmark/ips"
require "prime"

N = 200_000
S = Array.new(N){ (?a..?z).to_a.sample }

Benchmark.ips do |x|
  x.report("index") {
    a = Array.new(N,&:itself)
    ans = 1
    N.times do |i|
      ans += 1 if a[i].even?
    end
  }
  x.report("each") {
    a = Array.new(N,&:itself)
    ans = 1
    a.each do |a|
      ans += 1 if a.even?
    end
  }
  x.compare!
end
