require "spec"
require "crystal/persistent_queue"

describe PersistentQueue do
  it "usage" do
    q = PersistentQueue.new
    q0 = q << 6
    q1 = q0 << 7
    ans2, q2 = q1.shift
    ans2.should eq 6
    q3 = q << 8
    ans4, q4 = q3.shift
    ans4.should eq 8
    ans5, q5 = q1.shift
    ans5.should eq 6
  end
end
