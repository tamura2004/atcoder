require "spec"
require "crystal//game_search"

describe GameSearch do
  # 一度に３つまで取れるNim
  it "usage" do
    gs = GameSearch(Int32).new do |state|
      lo = Math.max(0, state-3)
      (lo...state).to_a
    end
    gs.solve(5).win?.should be_true
    gs.solve(4).lose?.should be_true
  end
end
