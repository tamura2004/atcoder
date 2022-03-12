require "spec"
require "../rolling_hash"

describe RollingHash do
  it "solve abc141e" do
    ABC141E.new("az").lcp.should eq 0
    ABC141E.new("zz").lcp.should eq 1
    ABC141E.new("zzz").lcp.should eq 1
    ABC141E.new("zbzbza").lcp.should eq 2
    ABC141E.new("abcab").lcp.should eq 2
    ABC141E.new("zaqrzarqazaqaarqaa").lcp.should eq 4 # arqa
    ABC141E.new("aaaaaaaaa").lcp.should eq 4
  end

  it "usage string" do
    s = RollingHash.new("0101")
t = RollingHash.new("01")
s[2,2].should eq t[0,2] # true
s[1,2].should_not eq t[0,2] # false

  end
end

class ABC141E < RollingHash
  def query(len : Int32) : Bool
    cnt = Hash(ModInt, Int32).new # ハッシュ値 => 最初の出現位置
    (n + 1 - len).times do |i|
      h = get(i, i + len)
      if cnt.has_key?(h)
        return true if cnt[h] + len <= i
      else
        cnt[h] = i
      end
    end
    return false
  end
  
  def lcp
    j = (0..n).bsearch do |i|
      len = n - i
      query(len)
    end
    return n - j if j
  end
end

