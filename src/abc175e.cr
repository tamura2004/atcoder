class State
  getter n : Int64
  property p : Array(Int64)
  property c : Array(Int64)

  def initialize(@n, @p, @c)
  end

  def nex
    np = Array.new(n, 0i64)
    nc = Array.new(n, 0i64)
    n.times do |i|
      np[i] = p[p[i]]
      nc[i] = c[i] + c[p[i]]
    end
    return State.new(n, np, nc)
  end
end

class Problem
  DEPTH = 32

  getter n : Int64
  getter k : Int64
  getter p : Array(Int64)
  getter c : Array(Int64)
  getter states : Array(State)

  def initialize(@n, @k, @p, @c)
    @states = [State.new(n, p, c)]
    DEPTH.times do
      states << states[-1].nex
    end
  end

  def get(i,x)
    cost = 0_i64
    DEPTH.downto(0) do |j|
      if x.bit(j) == 1
        cost += states[j].c[i]
        i = states[i].p[i]
      end
    end
    return cost
  end

  def solve
    n.times.max_of do |i|
      get(i,k)
    end
  end

  def self.read
    n, k = gets.to_s.split.map { |v| v.to_i64 }
    p = gets.to_s.split.map { |v| v.to_i64 - 1 }
    c = gets.to_s.split.map { |v| v.to_i64 }
    nc = n.times.map { |i| c[p[i]] }.to_a
    new(n, k, p, nc)
  end
end

pp Problem.read.states.first(3)
