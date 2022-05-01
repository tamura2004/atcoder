require "spec"
require "../matrix"

describe Matrix do
  it "usage" do
    a = Matrix(Int32).new([
      [1, 1],
      [1, 0],
    ])
    b = Matrix(Int32).new([
      [8, 5],
      [5, 3],
    ])
    (a*a*a*a*a).should eq b
    (a**5).should eq b
  end

  it "+ int" do
    m = Matrix.new([[1, 2], [3, 4]])
    (m + 1).a.should eq [[2, 3], [4, 5]]
  end

  it "- int" do
    m = Matrix.new([[1, 2], [3, 4]])
    (m - 1).a.should eq [[0, 1], [2, 3]]
  end

  it "* int" do
    m = Matrix.new([[1, 2], [3, 4]])
    (m * 2).a.should eq [[2, 4], [6, 8]]
  end

  it "// int" do
    m = Matrix.new([[1, 2], [3, 4]])
    (m // 2).a.should eq [[0, 1], [1, 2]]
  end
end
