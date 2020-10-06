require "spec"
require "../priority_queue"

describe PriorityQueue do
  it "usage" do
    pq = PriorityQueue(Int32).new
    pq << 4
    pq << 5
    pq << 1
    pq.pop.should eq 5
    pq.pop.should eq 4
    pq.pop.should eq 1
  end

  it "solve abc141d" do
    ABC141D.new(3,3,[2,13,8]).solve.should eq 9
    ABC141D.new(4,4,[1,9,3,5]).solve.should eq 6
    ABC141D.new(1,100000,[1000000000]).solve.should eq 0
  end
end

class ABC141D
  getter n : Int32
  getter m : Int32
  getter a : Array(Int32)

  def initialize(@n,@m,@a)
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