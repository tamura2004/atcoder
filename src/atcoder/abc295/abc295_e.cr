# 問題文の言い換えを行う
# 1-mの値を（均等とは限らない確率分布で）取る確率変数Xについて
# 期待値E(x) = Σ i in 1..m, i * P(X = i)
# ここでP(X = i)は Xがiである確率
# = Σ i in 1...m, P(X >= i) とできる既知の式変形がある
# こうするとAの種類数の問題に帰着できて
# P(X >= i) <=> Aの中にi以上がn+1-k個以上ある
# 例、n = 5, k = 4, i = 4の時
# i以上がn+1-k=2個以上ある || (n..k).size以上ある確率
# 1 1 3 4 5
# (1/6^5)*C(5,2)*(2/6)^2*(4/6)^3
# + (1/6^5)*C(5,3)*(2/6)^3*(4/6)^2
# + (1/6^5)*C(5,4)*(2/6)^4*(4/6)^1
# + (1/6^5)*C(5,5)*(2/6)^5*(4/6)^0

require "crystal/st"
require "crystal/modint9"
require "crystal/fact_table"

class Problem
  getter n : Int64
  getter m : Int64
  getter k : Int64
  getter a : Array(Int64)
  getter st : ST(Int64)
  getter zeros : Int64 # 0の個数

  def initialize(@n, @m, @k, @a)
    @st = (m + 1).to_st_sum
    a.each do |i|
      next if i.zero?
      st[i] += 1
    end
    @zeros = a.count(0).to_i64

    corner
  end

  def corner
    if zeros.zero?
      a.sort!
      quit a[k.pred]
    end
  end

  def self.read
    n, m, k = gets.to_s.split.map(&.to_i64)
    a = gets.to_s.split.map(&.to_i64)
    new(n, m, k, a)
  end

  # i以上が丁度j個出る確率
  def prob(i, j)
    return 0.to_m if j <= 0
    return 0.to_m if i == 1 && zeros != 1
    return 1.to_m if i == 1 && zeros == 1

    a1 = ((i..m).size.to_m // m) ** j
    a2 = ((1...i).size.to_m // m) ** (zeros - j)
    a3 = zeros.c(j)
    # pp! [i,j,a1, a2, a3, a1*a2*a3]
    a1*a2*a3
  end

  def solve
    ans = 0.to_m
    (1..m).each do |i|
      (k..n).each do |j|
        pp "----"
        puts "Aに#{i}以上が丁度#{(j..n).size}個ある確率1/#{1.to_m // prob(i, (j..n).size - st[i..m])}"
        ans += prob(i, (j..n).size - st[i..m])
      end
    end
    ans
  end
end

pp Problem.read.solve
