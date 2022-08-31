require "spec"
require "crystal/graph"
require "crystal/graph/backtrack"

describe Backtrack do
  it "usage" do
    g = Graph.new(3)
    g.add 3, 3, both: false
    g.add 2, 1, both: false
    Backtrack.new(g).solve.should eq [
      Backtrack::Game::Win,
      Backtrack::Game::Lose,
      Backtrack::Game::Draw,
    ]
  end
end
