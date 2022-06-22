# |str(m)|は|str(n)|の約数、|str(n)|//|str(m)| >= 2
# len = |str(m)|を全探索して、str(n)の先頭len文字を繰り返し？
# 繰り返しがnより大きかったら、-1
# ただし、引いて繰り下がりが発生するなら、9999
#
# 反例を探す
# 1000 -> 1010 x
# -> 909 x
# 11 ->
# 100 -> 99
# 200 -> 111
# 300 -> 222
# 101100 -> 100100
# 100100 -> 100100
# 100000 -> 100100

require "crystal/prime"

def solve(n)
  sn = n.to_s
  ln = sn.size

  ans = 0_i64

  ln.factors.each do |lm|
    next if lm == ln
    scale = ln // lm
    head = sn[0, lm]

    candi = head * scale
    if candi.to_i64 <= n
      chmax ans, candi.to_i64
    else
      snd = (head.to_i64 - 1).to_s
      if snd.size == head.size && snd.to_i64 > 0
        candi2 = snd * scale
        chmax ans, candi2.to_i64
      else
        candi3 = "9" * (ln - 1)
        chmax ans, candi3.to_i64
      end
    end
  end
  ans
end

t = gets.to_s.to_i64
t.times do
  n = gets.to_s.to_i64
  pp solve(n)
end
