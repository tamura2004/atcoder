require "spec"
require "crystal/modint9"
require "crystal/lst"

PW10 = [] of ModInt
x = 1.to_m
200_001.times do
  PW10 << x
  x *= 10
end

PW11 = [] of ModInt
x = 0.to_m
200_001.times do
  PW11 << x
  x *= 10
  x += 1
end

# 作用付きモノイド
class X
  getter val : ModInt
  getter len : Int32
  delegate to_s, inspect, to: val

  def initialize(@val, @len)
  end

  def self.zero
    new(1.to_m, 1)
  end

  def +(y : self)
    self.class.new(val * PW10[y.len] + y.val, len + y.len)
  end

  def *(a : A)
    self.class.new(PW11[len] * a.val, len)
  end
end

class A
  getter val : Int32

  def initialize(@val)
  end

  def +(b : self)
    b
  end
end

# 遅延評価セグメント木
describe LST do
  it "usage" do
    # 内部でnilを単位源としてモノイド化
    # 作用：文字の置き換え
    # クエリ：文字の連結
    # 結合操作にo(n)かかるので実用性は無い、が頭の体操用として例を残す
    st = LST(String, String).new(
      values: Array.new(8, "a"),
      fxx: ->(x : String, y : String) { x + " " + y },
      fxa: ->(x : String, a : String) { x.gsub(/[a-z]/, a) },
      faa: ->(a : String, b : String) { b }
    )

    st.sum.should eq "a a a a a a a a"
    st[2...7] = "b"
    st.sum.should eq "a a b b b b b a"
    st[1..2] = "c"
    st.sum.should eq "a c c b b b b a"
    st[5..] = "z"
    st.sum.should eq "a c c b b z z z"
    st[..6] = "y"
    st.sum.should eq "y y y y y y y z"
    st[0] = "a"
    st.sum.should eq "a y y y y y y z"
    st[4] = "b"
    st.sum.should eq "a y y y b y y z"
  end

  it "with monoid class" do
    st = LST(X, A).from_monoid(7)
    st.sum.to_s.should eq "1111111"
    st[1..5] = A.new(2)
    st.sum.to_s.should eq "1222221"
  end
end
