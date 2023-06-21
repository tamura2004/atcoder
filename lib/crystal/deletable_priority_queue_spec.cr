require "spec"
require "crystal/deletable_priority_queue"

describe DeletablePriorityQueue do
  it "usage" do
    pq = DPQ(Int32).greater
    pq << 3
    pq << 1
    pq << 4
    pq << 1
    pq << 5
    pq << 9
    pq << 2
    pq[0].should eq 9
    pq.delete 9
    pq[0].should eq 5
    pq.delete 1
    pq.pop.should eq 5
    pq.pop.should eq 4
    pq.pop.should eq 3
    pq.pop.should eq 2
    pq.pop.should eq 1
    pq.empty?.should eq true
  end
end
