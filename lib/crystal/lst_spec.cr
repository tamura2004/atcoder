require "spec"
require "crystal/lst"
require "crystal/complex"

# 区間更新、区間加算
# 複素数の実部を範囲の合計、虚部を範囲の個数として使用
class RangeUpdateRangeSum
  getter lst : LST(C, Int64)
  delegate "[]=", to: lst

  def initialize(values : Array(Int64))
    @lst = LST.new(
      values: values.map(&.to_c.+(1.y)),
      fxx: -> (x : C, y : C) { x + y },
      fxa: -> (x : C, a : Int64) { C.new(a * x.imag, x.imag) },
      faa: -> (a : Int64, b : Int64) { b },
    )
  end

  def [](r : Range(Int::Primitive?, Int::Primitive?))
    lst[r].x
  end

  def to_a
    lst.to_a.map(&.real)
  end
end

describe LST do
  it "区間更新、区間加算" do
    st = RangeUpdateRangeSum.new([0, 1, 0, 1].map(&.to_i64))
    st.to_a.should eq [0, 1, 0, 1]
    st[0..1] = 0_i64
    st[2..3] = 1_i64
    st[1..2].should eq 1
  end
end
