require "spec"
require "crystal/priority_queue"

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
    pq = PriorityQueue(Int32).lesser
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

  it "usage min heap with tuple" do
    pq = PriorityQueue(Tuple(Int32, Int32)).lesser
    pq << {4, 2}
    pq << {1, 5}
    pq << {3, 3}
    pq << {5, 1}
    pq << {2, 4}
    pq.pop.should eq ({1, 5})
    pq.pop.should eq ({2, 4})
    pq.pop.should eq ({3, 3})
    pq.pop.should eq ({4, 2})
    pq.pop.should eq ({5, 1})
  end
end
