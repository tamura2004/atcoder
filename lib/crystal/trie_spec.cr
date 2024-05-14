require "spec"
require "crystal/trie"

describe Trie do
  it "usage" do
    tr = Trie(Int64).new
    tr << "a"
    tr << "ab"
    tr << "aba"
    tr << "ba"
    tr << "bac"

    # 接頭辞が一致する文字列の数
    tr.count("a").should eq 3
    tr.count("ab").should eq 2
    tr.count("aba").should eq 1

    # 共通接頭辞の文字数の合計
    tr.sum("a").should eq 3
    tr.sum("ab").should eq 5
    tr.sum("aba").should eq 6
  end
end
