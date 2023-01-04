require "spec"
require "crystal/matrix"

alias M = Matrix(Int32)

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
    m = M.parse("1 2;3 4")
    (m // 2).should eq M.parse("0 1;1 2")
  end

  it "rot90" do
    m = M.parse("1 2;3 4")
    m.rot90.should eq M.parse("3 1;4 2")
  end

  it "rot180" do
    m = M.parse("1 2;3 4")
    m.rot180.should eq M.parse("4 3;2 1")
  end

  it "rot270" do
    m = M.parse("1 2;3 4")
    m.rot270.should eq M.parse("2 4;1 3")
  end

  it "transpose" do
    m = M.parse("1 2;3 4")
    m.transpose.should eq M.parse("1 3;2 4")
  end

  it "flip_lr" do
    m = M.parse("1 2;3 4")
    m.flip_lr.should eq M.parse("2 1;4 3")
  end

  it "flip_ud" do
    m = M.parse("1 2;3 4")
    m.flip_ud.should eq M.parse("3 4;1 2")
  end

  it "flip_diag" do
    m = M.parse("1 2;3 4")
    m.flip_diag.should eq M.parse("4 2;3 1")
  end

  it "index by complex" do
    m = M.parse("1 2;3 4")
    z = 1.x + 0.y
    m[z].should eq 2
  end

  it "change by complex" do
    m = M.parse("1 2;3 4")
    z = 1.x + 0.y
    m[z] = 5
    m[z].should eq 5
  end
  
  it "map" do
    m = M.parse("1 2;3 4")
    k = m.map(&.* 2)
    k.a.should eq [[2,4],[6,8]]
  end

  it "select" do
    m = M.parse("1 2;3 4")
    m.select(&.odd?).should eq [1,3]
  end
  
  it "select and sum" do
    m = M.parse("1 2;3 4")
    m.sum.should eq 10
  end

end
