require "spec"
require "crystal/lst"

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
end
