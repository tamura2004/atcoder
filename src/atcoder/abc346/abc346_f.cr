# 左から貪欲にとって良い
# k個取れるか？の判定問題を二分探索
# 判定問題：
# 今、i順目のj文字目にいるとき、k個とった位置は？
# sのi文字目以降でcを1個取った場所
# nex[i][abc][1個取った] := j
# memo[i][abc][2^j個取った] := 
# だぶりんぐ

require "crystal/range"

# ix = Array(Int32)が、i -> ix[i]に辺を張ったグラフであるとみなす時
# move(i, x): iからx進んだ先を、O(log x)で求める
class Doubling
  getter ix : Array(Int32)
  getter n : Int32
  getter pre : Array(Array(Int32)) # 事前計算、pre[i][k] -> iから2^k移動した先
  getter depth : Int32

  def initialize(@ix, @depth = 64)
    @n = @ix.size
    raise "error" if ix.any? { |v| v < 0 || n <= v }
    @pre = Array.new(@depth){ Array.new(n, 0) }
    pre[0] = @ix
    (1...depth).each do |k|
      n.times do |i|
        pre[k][i] = pre[k-1][pre[k-1][i]]
      end
    end
  end

  def move(i, x)
    ans = i
    depth.times do |k|
      next if x.bit(k) == 0
      ans = pre[k][ans]
    end
    ans
  end
end

# 文字列sが与えられた時
# nex[i] -> s内でs[i]が現れる次の位置、ただし１箇所のみならiを返す
class NextChar
  getter s : String
  getter n : Int32
  getter nex : Array(Int32)

  def initialize(@s)
    @n = s.size
    @nex = Array.new(n, -1)
    memo = {} of Char => Int32
    s.chars.zip(0..).reverse_each do |c, i|
      if memo.has_key?(c)
        @nex[i] = memo[c]
      end
      memo[c] = i
    end
    n.times do |i|
      if nex[i] == -1
        nex[i] = memo[s[i]]
      end
    end
  end
end

n = gets.to_s.to_i
s = gets.to_s
m = s.size.to_i
t = gets.to_s

nex = NextChar.new(s).nex
db = Doubling.new(nex)


