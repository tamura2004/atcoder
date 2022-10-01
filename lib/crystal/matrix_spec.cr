require "spec"
require "crystal/matrix"

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

  it "zero" do
    Matrix(Int32).zero(2).a.should eq [[0, 0], [0, 0]]
    Matrix(Int32).zero(2, 3).a.should eq [[0, 0, 0], [0, 0, 0]]
  end

  it "unit" do
    Matrix(Int32).unit(2).a.should eq [[1, 0], [0, 1]]
    Matrix(Int32).identity(2).a.should eq [[1, 0], [0, 1]]
    Matrix(Int32).i(2).a.should eq [[1, 0], [0, 1]]
  end

  it "[]" do
    Matrix(Int32)[[0, 1], [1, 0]].a.should eq [[0, 1], [1, 0]]
  end

  it "build" do
    Matrix(Int32).build(3) { |y, x| y*x }.a.should eq [[0, 0, 0], [0, 1, 2], [0, 2, 4]]
    Matrix(Int32).build(2, 3) { |y, x| y*x }.a.should eq [[0, 0, 0], [0, 1, 2]]
  end

  it "* vector" do
    (Matrix(Int32)[[1, 2], [3, 4]] * [5, 6]).should eq [17, 39]
  end

  it "+ int" do
    m = Matrix(Int32).new([[1, 2], [3, 4]])
    (m + 1).a.should eq [[2, 3], [4, 5]]
  end

  it "- int" do
    m = Matrix(Int32).new([[1, 2], [3, 4]])
    (m - 1).a.should eq [[0, 1], [2, 3]]
  end

  it "* int" do
    m = Matrix(Int32).new([[1, 2], [3, 4]])
    (m * 2).a.should eq [[2, 4], [6, 8]]
  end

  it "// int" do
    m = Matrix(Int32).new([[1, 2], [3, 4]])
    (m // 2).a.should eq [[0, 1], [1, 2]]
  end
end
