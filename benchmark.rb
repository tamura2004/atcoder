require "benchmark/ips"
require "prime"

class A
  def initialize(a)
    @a = a
  end

  def x
    @a * 2
  end
end

class B
  attr_accessor :b
  def initialize(a)
    @b = a
  end

  def x
    b * 2
  end
end

Benchmark.ips do |x|
  x.report("a") {
    a = A.new(10)
    a.x
  }
  x.report("b") {
    a = B.new(10)
    a.x
  }
  x.compare!
end
