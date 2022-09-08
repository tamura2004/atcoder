require "spec"
require "crystal/graph"
require "crystal/graph/euler_tour"

describe EulerTour do
  it "usage" do
    g = Graph.new(5)
    g.add 1, 2, 100
    g.add 1, 3, 100
    g.add 2, 4, 100
    g.add 2, 5, 100
    et = EulerTour.new(g, 0)
    et.enter.should eq [0, 1, 7, 2, 4]
    et.leave.should eq [9, 6, 8, 3, 5]
    et.events.should eq [
      { 0, EulerTour::Event::Enter },
      { 1, EulerTour::Event::Enter },
      { 3, EulerTour::Event::Enter },
      { 3, EulerTour::Event::Leave },
      { 4, EulerTour::Event::Enter },
      { 4, EulerTour::Event::Leave },
      { 1, EulerTour::Event::Leave },
      { 2, EulerTour::Event::Enter },
      { 2, EulerTour::Event::Leave },
      { 0, EulerTour::Event::Leave }
  ]
  end
end
