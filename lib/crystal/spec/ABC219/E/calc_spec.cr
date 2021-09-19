require "spec"
require "crystal/ABC219/E/calc"
include Abc219::E

describe Abc219::E::Connected do
  it "1" do
    a = [
      [0,0,0,1],
      [0,0,0,1],
      [0,0,0,1],
      [0,0,0,1],
    ]
    Connected.new(a).solve.should eq true
  end

  it "1" do
    a = [
      [1,1,1,1],
      [0,0,0,1],
      [1,1,1,1],
      [0,1,0,0],
    ]
    Connected.new(a).solve.should eq true
  end

  it "2" do
    a = [
      [0,0,0,1],
      [1,0,0,1],
      [1,1,0,1],
      [0,0,0,1],
    ]
    Connected.new(a).solve.should eq false
  end

  it "3" do
    a = [
      [0,0,0,1],
      [0,0,0,1],
      [1,1,1,1],
      [0,0,0,1],
    ]
    Connected.new(a).solve.should eq true
  end


  it "hole" do
    a = [
      [1,1,1,1],
      [1,0,0,1],
      [1,1,1,1],
      [0,0,0,1],
    ]
    Hole.new(a).solve.should eq 1
  end

  it "3" do
    a = [
      [0,0,0,1],
      [0,0,0,1],
      [1,1,1,1],
      [0,0,0,1],
    ]
    n = "0001000111110001".to_i(2)
    # ToArr.new(n).solve.should eq a
  end
end
