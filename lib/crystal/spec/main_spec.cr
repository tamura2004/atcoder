require "spec"
require "../../../src/main"

describe "main" do
  it "cyclic compress" do
    Problem.new(2,[2_i64,3_i64]).solve.should eq nil
  end
end
