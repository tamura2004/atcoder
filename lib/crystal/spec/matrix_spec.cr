require "spec"
require "../matrix"

describe Matrix do
  it "solve abc009D case 3" do
    input = [
      "30 999999999",
      "11627 5078 8394 6412 10346 3086 3933 668 9879 11739 4501 6108 12336 8771 2768 2438 2153 7047 5476 313 1264 369 12070 10743 10663 747 370 4671 5235 3439",
      "114 3613 3271 5032 11241 6961 3628 150 12191 2396 7638 3046 11594 8162 11136 786 9878 2356 11660 1070 3649 10882 9746 1415 3307 7077 9319 9981 3437 544"
    ]
    ABC009D.solve(input).should eq 2148
  end
  
  it "solve abc009D case 2" do
    input = [
      "5 100",
      "2345678901 1001001001 3333333333 3141592653 1234567890",
      "2147483648 2147483647 4294967295 4294967294 3434343434",
    ]
    ABC009D.solve(input).should eq 1067078691
  end
end

module ABC009D
  extend self
  def solve(input)
    n,x = input[0].split.map { |v| v.to_i }
    a = input[1].split.map { |v| v.to_i64 }
    c = input[2].split.map { |v| v.to_i64 }

    if x <= n
      return a[x-1]
    end

    mc = Matrix(Int64).new(n)
    ma = Matrix(Int64).new(n)

    n.times do |i|
      mc[0][i] = c[i]
    end

    1.upto(n-1) do |j|
      mc[j][j-1] = ~Int64.zero
    end

    n.times do |j|
      ma[j][0] = a[n-1-j]
    end

    ans = mc ** (x - n) * ma
    return ans[0][0]
  end
end