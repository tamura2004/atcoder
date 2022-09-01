require "spec"
require "../sqrt_decomposition"

describe SqrtDecompositionRSUM do
  it "usage" do
    rsum = SqrtDecompositionRSUM.new(10)
    10.times do |i|
      rsum[i] = i + 1
    end
    rsum[0, 9].should eq 55
  end
end

describe SqrtDecompositionRMQ do
  it "usage" do
    a = [5, 1, 4, 2, 3].map(&.to_i64)
    rmq = SqrtDecompositionRMQ.new(a)
    rmq[0, 5].should eq 1
    rmq[3, 5].should eq 2
  end
end

# 区間更新、１点読み出し、最小値
describe SqrtDecompositionRangeUpdateQuery do
  it "usage" do
    rmq = SqrtDecompositionRangeUpdateQuery.new(100_000)
    rmq[0, 100_000] = 100
    rmq[0].should eq 100
    rmq[1].should eq 100
    rmq[5000].should eq 100
    rmq[99_999].should eq 100
    rmq[100_000].should eq Int32::MAX

    rmq[100, 90_000] = 50
    rmq[0].should eq 100
    rmq[1].should eq 100
    rmq[99].should eq 100
    rmq[100].should eq 50
    rmq[101].should eq 50
    rmq[5000].should eq 50
    rmq[89_999].should eq 50
    rmq[90_000].should eq 100
    rmq[90_001].should eq 100
    rmq[99_999].should eq 100
    rmq[100_000].should eq Int32::MAX

    rmq[5_000, 95_000] = 25
    rmq[0].should eq 100
    rmq[1].should eq 100
    rmq[99].should eq 100
    rmq[100].should eq 50
    rmq[101].should eq 50
    rmq[4999].should eq 50
    rmq[5000].should eq 25
    rmq[5001].should eq 25
    rmq[89_999].should eq 25
    rmq[90_000].should eq 25
    rmq[90_001].should eq 25
    rmq[94_999].should eq 25
    rmq[95_000].should eq 100
    rmq[95_001].should eq 100
    rmq[99_999].should eq 100
    rmq[100_000].should eq Int32::MAX
  end

  it "solve ABC179F" do
    ABC179F.new.solve.should eq 31159505795
  end
end

class ABC179F
  getter n : Int32
  getter query : Array(String)

  def initialize
    @n = 176527
    @query = [
      "1 81279",
      "2 22308",
      "2 133061",
      "1 80744",
      "2 44603",
      "1 170938",
      "2 139754",
      "2 15220",
      "1 172794",
      "1 159290",
      "2 156968",
      "1 56426",
      "2 77429",
      "1 97459",
      "2 71282",
    ]
  end

  def solve
    tate = SqrtDecompositionRangeUpdateQuery.new(n)
    yoko = SqrtDecompositionRangeUpdateQuery.new(n)
    tate[0, n] = n - 1
    yoko[0, n] = n - 1
    yoko_min = n - 1
    tate_min = n - 1
    ans = (n - 2).to_i64 ** 2

    query.each do |line|
      cmd, i = line.split.map { |v| v.to_i - 1 }
      case cmd
      when 0
        x = yoko[i]
        ans -= x - 1
        if i <= yoko_min
          tate[0, tate_min] = i
          yoko_min = i
        end
      when 1
        x = tate[i]
        ans -= x - 1
        if i <= tate_min
          yoko[0, yoko_min] = i
          tate_min = i
        end
      end
    end

    return ans
  end
end
