require "spec"
require "../problem"

describe Problem do
  it "未満の個数を二分探索で求める" do
    Problem.new.tap do |p|
      p.count_less([1,3,5,7,9], 1).sould eq 0
      p.count_less([1,3,5,7,9], 2).sould eq 1
      p.count_less([1,3,5,7,9], 3).sould eq 1
      p.count_less([1,3,5,7,9], 8).sould eq 4
      p.count_less([1,3,5,7,9], 9).sould eq 4
      p.count_less([1,3,5,7,9], 10).sould eq 5
    end
  end
end
