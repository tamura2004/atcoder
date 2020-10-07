require "spec"
require "../priority_queue"

record Edge, to : Int32, cost : Int32

describe PriorityQueue do
  it "usage max heap" do
    pq = PriorityQueue(Int32).new
    pq << 1
    pq << 2
    pq << 3
    pq << 4
    pq << 5
    pq.pop.should eq 5
    pq.pop.should eq 4
    pq.pop.should eq 3
    pq.pop.should eq 2
    pq.pop.should eq 1
  end

  it "usage min heap" do
    pq = PriorityQueue(Int32).new { |a, b| a > b }
    pq << 5
    pq << 4
    pq << 3
    pq << 2
    pq << 1
    pq.pop.should eq 1
    pq.pop.should eq 2
    pq.pop.should eq 3
    pq.pop.should eq 4
    pq.pop.should eq 5
  end

  it "usage min heap with record" do
    pq = PriorityQueue(Edge).new { |a, b| a.cost > b.cost }
    pq << Edge.new(to: 1, cost: 5)
    pq << Edge.new(to: 2, cost: 4)
    pq << Edge.new(to: 3, cost: 3)
    pq << Edge.new(to: 4, cost: 2)
    pq << Edge.new(to: 5, cost: 1)
    pq.pop.cost.should eq 1
    pq.pop.cost.should eq 2
    pq.pop.cost.should eq 3
    pq.pop.cost.should eq 4
    pq.pop.cost.should eq 5
  end

  it "solve abc141d" do
    ABC141D.new(3, 3, [2, 13, 8]).solve.should eq 9
    ABC141D.new(4, 4, [1, 9, 3, 5]).solve.should eq 6
    ABC141D.new(1, 100000, [1000000000]).solve.should eq 0
  end

  it "solve abc077d" do
    ABC077D.new(6).solve(1,0).should eq 3
    ABC077D.new(41).solve(1,0).should eq 5
    ABC077D.new(79992).solve(1,0).should eq 36
  end
end

class ABC141D
  getter n : Int32
  getter m : Int32
  getter a : Array(Int32)

  def initialize(@n, @m, @a)
  end

  def solve
    que = PriorityQueue(Int32).new
    a.each do |v|
      que << v
    end

    m.times do
      x = que.pop
      que << x // 2
    end

    ans = 0
    while que.size > 0
      ans += que.pop
    end
    ans
  end
end

class ABC077D
  getter k : Int32
  property g : Array(Array(Edge))

  def initialize(@k)
    @g = Array.new(k) { [] of Edge }
    k.times do |i|
      g[i] << Edge.new(to: (i + 1) % k, cost: 1)
      g[i] << Edge.new(to: (i*10) % k, cost: 0)
    end
  end

  def solve(start, goal)
    q = PriorityQueue(Edge).new { |a, b| a.cost > b.cost }
    seen = Array.new(k, false)
    seen[start] = true
    q << Edge.new(to: start, cost: 1)
    while q.size > 0
      v = q.pop
      return v.cost if v.to == goal
      seen[v.to] = true
      
      g[v.to].each do |nv|
        next if seen[nv.to]
        q << Edge.new(to: nv.to, cost: v.cost + nv.cost)
      end
    end
  end
end