require "spec"
require "crystal/lst"

describe LST do
  it "区間更新、区間最小" do
    st = LST.new(
      n: 10,
      fxx: ->Math.min(Int32,Int32),
      fxa: ->Math.min(Int32,Int32),
      faa: ->Math.min(Int32,Int32)
    )
    st[..5] = 100
    st[5..] = 50
    st.query(3,5).should eq 100
    # st[5..6].should eq 50
    # st[6..].should eq 50
  end
end





# PW10 = [] of ModInt
# x = 1.to_m
# 200_001.times do
#   PW10 << x
#   x *= 10
# end

# PW11 = [] of ModInt
# x = 0.to_m
# 200_001.times do
#   PW11 << x
#   x *= 10
#   x += 1
# end

# # 作用付きモノイド
# class X
#   getter val : ModInt
#   getter len : Int32
#   delegate to_s, inspect, to: val

#   def initialize(@val, @len)
#   end

#   def self.zero
#     new(1.to_m, 1)
#   end

#   def +(y : self)
#     self.class.new(val * PW10[y.len] + y.val, len + y.len)
#   end

#   def *(a : A)
#     self.class.new(PW11[len] * a.val, len)
#   end
# end

# class A
#   getter val : Int32

#   def initialize(@val)
#   end

#   def +(b : self)
#     b
#   end
# end

# # 遅延評価セグメント木
# describe LST do
#   it "usage" do
#     # 内部でnilを単位源としてモノイド化
#     # 作用：文字の置き換え
#     # クエリ：文字の連結
#     # 結合操作にo(n)かかるので実用性は無い、が頭の体操用として例を残す
#     st = LST(String, String).new(
#       values: Array.new(8, "a"),
#       fxx: ->(x : String, y : String) { x + " " + y },
#       fxa: ->(x : String, a : String) { x.gsub(/[a-z]/, a) },
#       faa: ->(a : String, b : String) { b }
#     )

#     st.sum.should eq "a a a a a a a a"
#     st[2...7] = "b"
#     st.sum.should eq "a a b b b b b a"
#     st[1..2] = "c"
#     st.sum.should eq "a c c b b b b a"
#     st[5..] = "z"
#     st.sum.should eq "a c c b b z z z"
#     st[..6] = "y"
#     st.sum.should eq "y y y y y y y z"
#     st[0] = "a"
#     st.sum.should eq "a y y y y y y z"
#     st[4] = "b"
#     st.sum.should eq "a y y y b y y z"
#   end

#   it "with monoid class" do
#     st = LST(X, A).from_monoid(7)
#     st.sum.to_s.should eq "1111111"
#     st[1..5] = A.new(2)
#     st.sum.to_s.should eq "1222221"
#   end

#   it "range_update_range_sum" do
#     st = LST(Tuple(Int64, Int64), Int64).new(
#       Array.new(8) { nil.as(Tuple(Int64,Int64)?) },
#       fxx: ->(x : Tuple(Int64, Int64), y : Tuple(Int64, Int64)) {
#         {x[0] + y[0], x[1] + y[1]}
#       },
#       fxa: ->(x : Tuple(Int64, Int64), a : Int64) {
#         {a * x[1], x[1]}
#       },
#       faa: ->(a : Int64, b : Int64) { b }
#     )

#     st[2] = {100_i64, 1_i64}
#     st[0..7].should eq ({100, 1})
#   end
# end
