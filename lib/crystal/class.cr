class Problem
  getter n : Int32
  getter a : Array(Int64)

  def self.read(io : IO)
    n = io.gets.to_s.to_i
    a = io.gets.to_s.split.map(&.to_i64)
    new(n, a)
  end

  def self.read
    read(STDIN)
  end
  
  def self.read(input : String)
    read(IO::Memory.new(input))
  end

  def initialize(@n, @a)
  end

  def solve
  end
end