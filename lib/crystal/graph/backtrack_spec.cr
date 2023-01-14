require "spec"
require "crystal/graph"
require "crystal/graph/backtrack"

# 後退解析によりゲーム木のノードごとの勝敗・引き分けを求める
describe Backtrack do
  it "usage" do
    g = Graph.new(3)
    g.add 3, 3, both: false
    g.add 2, 1, both: false
    Backtrack.new(g).solve.should eq [
      Backtrack::Game::Lose,
      Backtrack::Game::Win,
      Backtrack::Game::Draw,
    ]
  end

  it "usage" do
    g = Graph.new(3)
    g.add 1, 2, both: false
    g.add 1, 3, both: false
    Backtrack.new(g).solve.should eq [
      Backtrack::Game::Win,
      Backtrack::Game::Lose,
      Backtrack::Game::Lose,
    ]
  end
  
  it "abst graph" do
    g = BaseGraph(Tuple(Int32,Int32)).new
    g.add ({1,0}), ({3,1}), both: false
    g.add ({3,1}), ({7,2}), both: false
    Backtrack.new(g).solve.should eq [
      Backtrack::Game::Lose,
      Backtrack::Game::Win,
      Backtrack::Game::Lose,
    ]
  end
end